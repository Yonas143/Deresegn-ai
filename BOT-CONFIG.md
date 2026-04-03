# Bot Configuration

## Update Your Bot Username

After creating your bot with @BotFather, you need to update the landing page with your bot's username.

### Step 1: Get Your Bot Username

When you created the bot with @BotFather, you chose a username (e.g., `scanlogic_bot`).

### Step 2: Update the Landing Page

Open `public/index.html` and replace `YOUR_BOT_USERNAME` with your actual bot username in these places:

1. Line with: `href="https://t.me/YOUR_BOT_USERNAME"`
2. Search for all instances of `YOUR_BOT_USERNAME` and replace

**Example:**
```html
<!-- Before -->
<a href="https://t.me/YOUR_BOT_USERNAME" class="cta-button">

<!-- After (if your bot is @scanlogic_bot) -->
<a href="https://t.me/scanlogic_bot" class="cta-button">
```

### Quick Find & Replace

Use your editor's find and replace:
- Find: `YOUR_BOT_USERNAME`
- Replace with: `your_actual_bot_username` (without the @)

### Step 3: Commit and Push

```bash
git add public/index.html
git commit -m "Update bot username in landing page"
git push origin main
```

Render will automatically redeploy with the updated landing page!
