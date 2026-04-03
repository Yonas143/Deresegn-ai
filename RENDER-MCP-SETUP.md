# Setting Up Render MCP Server in Kiro

## What is Render MCP?

Render's Model Context Protocol (MCP) server lets you manage your Render infrastructure using AI assistants. You can deploy, monitor, and manage your services using natural language.

## Setup Steps

### 1. Get Your Render API Key

1. Go to https://dashboard.render.com/u/settings
2. Scroll to "API Keys"
3. Click "Create API Key"
4. Copy the key (keep it safe!)

### 2. Configure MCP in Kiro

Add this to your Kiro MCP configuration (`~/.kiro/settings/mcp.json`):

```json
{
  "mcpServers": {
    "render": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "RENDER_API_KEY=YOUR_API_KEY_HERE",
        "public.ecr.aws/render/mcp-server:latest"
      ],
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

Replace `YOUR_API_KEY_HERE` with your actual Render API key.

### 3. Set Your Workspace

In Kiro, you can now use commands like:
```
Set my Render workspace to [YOUR_WORKSPACE_NAME]
```

## What You Can Do

### Deploy Services
```
Deploy my Telegram bot to Render using the Deresegn-ai repo
```

### Check Logs
```
Show me the latest logs from my scanlogic-bot service
Pull error logs from the last hour
```

### Monitor Performance
```
What was the busiest traffic day this week?
Show me autoscaling behavior for yesterday
```

### Manage Databases
```
Create a new Postgres database named bot-db with 5GB storage
Query my database for user statistics
```

### Debug Issues
```
Why isn't my bot responding?
Check the health of my services
```

## Security Note

⚠️ **Important**: Render API keys have broad access to all your workspaces and services. Only use this in trusted environments.

## Alternative: Use Render Dashboard

If you prefer not to set up MCP, you can always manage your services through:
- Render Dashboard: https://dashboard.render.com
- Render CLI: https://render.com/docs/cli

## Benefits of Using MCP

- ✅ Faster deployments with natural language
- ✅ Quick log analysis and debugging
- ✅ Monitor multiple services at once
- ✅ Automated infrastructure management
- ✅ Works directly in your AI assistant

## Current Deployment Status

Your bot is ready to deploy! You can either:

1. **Manual Deploy**: Follow RENDER-DEPLOY.md
2. **With MCP**: Set up MCP and use: "Deploy my Telegram bot to Render"

Both methods work - MCP just makes it faster and more conversational!
