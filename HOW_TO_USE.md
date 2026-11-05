# flutter-kit-widgets — How to Use

## What's Inside

Reusable UI widget kit. Each widget is **individually downloadable** — only add what you need.

| Widget | File | Purpose |
|--------|------|---------|
| `ButtonComponent` | `button_component.dart` | Primary/grey/outline/delete/edit buttons with gradient + animation |
| `InputField` | `text_field_component.dart` | Full-featured text field with label, validation, password, etc. |
| `ResponseWidget` | `response_widget.dart` | Inline success/error feedback banner |
| `AppLoader` | `app_loader.dart` | Gradient shimmer loading indicator |
| `LoaderOverlay` | `loader_overlay.dart` | Full-screen black overlay with centered loader |
| `CustomSnackBar` | `custom_snackbar.dart` | Top-sliding overlay snackbar (success/error) |
| `AppDialog` | `dialogs_widget/app_dialog.dart` | Static dialog utility (delete, warning, logout, etc.) |
| `DialogType` | `dialogs_widget/dialog_types.dart` | Dialog type config enum |
| `CachedImageComponent` | `cache_image_component.dart` | Cached network image with placeholder |
| `TextComponent` | `text_component.dart` | Text widget with gradient support + character limit |

---

## Dependencies Required

```yaml
dependencies:
  flutter_screenutil: ^5.0.0
  flutter_animate: ^4.0.0
  iconly: ^2.0.0
  cached_network_image: ^3.0.0
  material_loading_indicator: ^1.0.0
```

Also requires **flutter-kit-core** for:
- `AppNavigator` (colors, gradients)
- `AppRouter.navigatorKey` (for `AppDialog`)
- `theme_extensions.dart` (context.colors)

---

## Individual Widget Usage

### ButtonComponent

```dart
// Primary gradient button
ButtonComponent.primary(
  text: 'Save',
  onPressed: () => _save(),
)

// Grey button
ButtonComponent.grey(text: 'Cancel', onPressed: () => Navigator.pop(context))

// Delete (red) button
ButtonComponent.delete(text: 'Delete', onPressed: () => _delete(), isLoading: state.isLoading)

// Outline button
ButtonComponent.outline(text: 'Edit', onPressed: () => _edit())

// Custom button
ButtonComponent(
  buttonText: 'Custom',
  onPressed: () {},
  gradient: [Colors.blue, Colors.purple],
  radius: 8,
  height: 50,
)
```

### InputField

```dart
InputField(
  labelText: 'Email',
  hintText: 'Enter your email',
  controller: _emailController,
  keyboardType: TextInputType.emailAddress,
  validator: Validators.validateEmail,
)

// Password field
InputField(
  labelText: 'Password',
  isPassword: true,
  obscureText: _obscure,
  suffixIcon: IconButton(
    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
    onPressed: () => setState(() => _obscure = !_obscure),
  ),
  validator: Validators.validatePassword,
)
```

### ResponseWidget

```dart
// In BlocBuilder
if (state.errorMessage != null)
  ResponseWidget.error(title: state.errorMessage!)

if (state.successMessage != null)
  ResponseWidget.success(title: state.successMessage!)
```

### AppLoader / LoaderOverlay

```dart
// Inline loader
const AppLoader()

// Full-screen overlay — wrap in Stack
Stack(children: [
  _mainContent(),
  if (state.isLoading) const LoaderOverlay(),
])
```

### CustomSnackBar

```dart
// Show success
CustomSnackBar.success(context, 'Profile updated successfully');

// Show error
CustomSnackBar.error(context, state.message ?? 'Something went wrong');
```

### AppDialog

```dart
// Delete confirmation
AppDialog.delete(
  title: 'Delete Post',
  message: 'This post will be permanently deleted.',
  onConfirm: () => context.read<PostCubit>().delete(id),
);

// Logout confirmation
AppDialog.logout(onConfirm: () => context.read<SessionCubit>().logout());

// Warning
AppDialog.warning(
  title: 'Skip Step?',
  message: 'You can complete this later in settings.',
  confirmText: 'Skip',
  onConfirm: () => _skip(),
);

// Success (no confirm button — just info)
AppDialog.success(title: 'Email Sent', message: 'Check your inbox to verify your email.');

// Subscription upsell
AppDialog.subscription(onConfirm: () => context.push(Routes.plans.path));

// Generic show (custom widget)
AppDialog.show(MyCustomDialog());
```

### CachedImageComponent

```dart
CachedImageComponent(
  imageUrl: user.avatarUrl,
  imageSize: 48,
  imageBoxFit: BoxFit.cover,
  defaultWidget: const CircleAvatar(child: Icon(Icons.person)),
)
```

### TextComponent

```dart
// Normal text
TextComponent(
  text: 'Hello World',
  fontsize: 18,
  fontWeight: FontWeight.bold,
)

// Gradient text
TextComponent(
  text: 'Premium',
  color: AppNavigator.gradients.primaryGradient,
  fontWeight: FontWeight.w700,
)

// Truncate by characters
TextComponent(
  text: longText,
  maxCharacters: 100,
  overflow: TextOverflow.ellipsis,
)
```

---

## Requires flutter-kit-core

Copy these from flutter-kit-core before using this kit:
- `lib/core/app_navigator.dart`
- `lib/core/routing/app_router.dart` (for `AppDialog.navigatorKey`)
- `lib/core/theme/theme_extensions.dart`
- `lib/core/constants/app_colors.dart`
- `lib/core/theme/gradient_theme_extension.dart`
