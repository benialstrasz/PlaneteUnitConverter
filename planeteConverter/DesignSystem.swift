//
//  DesignSystem.swift
//  planeteConverter
//
//  Liquid Glass design tokens + reusable SwiftUI modifiers.
//

import SwiftUI

enum DS {
	// Base corner radius used across panels/fields/buttons.
	static let cornerRadius: CGFloat = 18
	static let smallCornerRadius: CGFloat = 12

	// A subtle, app-wide background tint to give the glass something to refract.
	// Using semantic colors keeps this compatible with light/dark mode.
	static var baseGradient: LinearGradient {
		LinearGradient(
			colors: [
				Color.accentColor.opacity(0.18),
				Color.primary.opacity(0.05),
				Color.clear
			],
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
	}

	// A prominent stroke that reads as the glass “edge”.
	static var glassStroke: some ShapeStyle {
		Color.white.opacity(0.26)
	}

	// A secondary stroke to increase definition on bright backgrounds.
	static var glassStrokeSecondary: some ShapeStyle {
		Color.black.opacity(0.08)
	}
}

// MARK: - Glass surfaces

private struct GlassSurfaceModifier: ViewModifier {
	var cornerRadius: CGFloat
	var material: Material
	var highlightOpacity: CGFloat
	var shadowOpacity: CGFloat

	func body(content: Content) -> some View {
		content
			.background {
				RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
					.fill(material)
					// Specular highlight (top-left)
					.overlay {
						RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
							.fill(
								LinearGradient(
									colors: [
										Color.white.opacity(highlightOpacity),
										Color.clear
									],
									startPoint: .topLeading,
									endPoint: .center
								)
							)
					}
					// Rim stroke
					.overlay {
						RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
							.strokeBorder(DS.glassStroke, lineWidth: 1)
							.overlay {
								RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
									.strokeBorder(DS.glassStrokeSecondary, lineWidth: 1)
							}
					}
					.shadow(color: .black.opacity(shadowOpacity), radius: 18, x: 0, y: 10)
			}
	}
}

extension View {
	/// A reusable translucent, glass-like container.
	func glassSurface(
		cornerRadius: CGFloat = DS.cornerRadius,
		material: Material = .ultraThinMaterial,
		highlightOpacity: CGFloat = 0.28,
		shadowOpacity: CGFloat = 0.14
	) -> some View {
		modifier(
			GlassSurfaceModifier(
				cornerRadius: cornerRadius,
				material: material,
				highlightOpacity: highlightOpacity,
				shadowOpacity: shadowOpacity
			)
		)
	}
}

// MARK: - Glass button styles

struct GlassIconButtonStyle: ButtonStyle {
	var tint: Color = .accentColor

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.foregroundStyle(tint)
			.padding(10)
			.contentShape(Circle())
			.background {
				Circle()
					.fill(.ultraThinMaterial)
					.overlay { Circle().strokeBorder(DS.glassStroke, lineWidth: 1) }
			}
			.scaleEffect(configuration.isPressed ? 0.96 : 1.0)
			.shadow(color: .black.opacity(configuration.isPressed ? 0.10 : 0.16), radius: 14, x: 0, y: 8)
			.animation(.snappy(duration: 0.18), value: configuration.isPressed)
	}
}

// MARK: - Glass field style

struct GlassFieldStyle: TextFieldStyle {
	@Environment(\.isEnabled) private var isEnabled

	func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.textFieldStyle(.plain)
			.padding(.horizontal, 10)
			.padding(.vertical, 7)
			.background {
				RoundedRectangle(cornerRadius: DS.smallCornerRadius, style: .continuous)
					.fill(.thinMaterial)
					.overlay {
						RoundedRectangle(cornerRadius: DS.smallCornerRadius, style: .continuous)
							.strokeBorder(DS.glassStroke, lineWidth: 1)
					}
			}
			.opacity(isEnabled ? 1 : 0.6)
	}
}
