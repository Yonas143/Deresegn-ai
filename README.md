# Deresegn AI: AI-Powered Receipt & Document Assistant

[![Open Source](https://img.shields.io/badge/Open%20Source-MIT-green.svg)](LICENSE)
[![Deploy to Render](https://img.shields.io/badge/Deploy%20to-Render-46E3B7.svg)](https://render.com)
[![Telegram Bot](https://img.shields.io/badge/Telegram-Bot-blue.svg)](https://t.me/Mybillsaibot)

Deresegn AI is a production-ready, full-stack AI assistant designed to simplify expense tracking and document management. It leverages Google Gemini for intelligent OCR and data extraction, Supabase for secure data persistence, and Telegram as a lightweight, accessible interface.

**🚀 Open Source & Self-Hostable** - Deploy your own instance in minutes!

---

## ✨ Features

- 📸 **Smart Receipt Scanning** - AI-powered OCR extracts merchant, amount, date, and category
- 💬 **Natural Language Queries** - Ask "How much did I spend this week?" and get instant answers
- 📊 **Expense Analytics** - Track spending by category, merchant, or time period
- 🔍 **Smart Search** - Find any receipt instantly
- 📄 **PDF Form Filling** - Auto-fill forms using your saved profile
- 📥 **Export Reports** - Download Excel/PDF reports for accounting

---

## 🚀 Quick Deploy

### Deploy to Render (Recommended)

1. Click the button below or follow [RENDER-DEPLOY.md](RENDER-DEPLOY.md)

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

2. Add your environment variables (see [.env.example](.env.example))
3. Your bot is live! 🎉

### Other Platforms

- **Railway**: See [deployment docs](RENDER-DEPLOY.md)
- **Google Cloud Run**: Compatible
- **Heroku**: Compatible
- **Self-hosted**: Works on any Node.js server

---

## 🚀 How to Use

### 1. Telegram Bot Interface
The primary way to interact with ScanLogic is through the Telegram bot.
- **Register Receipts**: Simply send a photo of a receipt. The AI will automatically extract the merchant, total, currency, date, and category.
- **Query Expenses**: Ask natural language questions like:
  - *"How much did I spend this week?"*
  - *"Show me the receipt from Kaldis Coffee."*
- **Export Reports**: Use the `/export` command or the "Export Report" button to receive an Excel summary of your data.
- **Fill Forms**: Upload a PDF form, and the bot will offer to fill it using your saved profile data.

### 2. Web Dashboard
Access the web interface to view a visual summary of your spending, manage your profile, and see a history of all uploaded documents.

---

## 🛠 Tech Stack

- **Frontend**: React 19, Vite, Tailwind CSS 4, Motion (Framer Motion).
- **Backend**: Node.js (Express), TypeScript.
- **Database**: Supabase (PostgreSQL) for structured data and Auth.
- **AI Engine**: Google Gemini 1.5 Flash (`@google/genai`) for high-speed OCR and intent analysis.
- **File Processing**: `pdf-lib` for PDF manipulation and `xlsx` for Excel report generation.
- **Communication**: Telegram Bot API.

---

## 🏗 Project Structure

```text
├── server.ts            # Main entry point: Express server & Telegram Webhook
├── src/                 # React Frontend application
│   ├── components/      # UI components (Tailwind + Lucide)
│   ├── App.tsx          # Main dashboard logic
│   └── main.tsx         # React entry point
├── .env.example         # Template for environment variables
├── package.json         # Dependencies and scripts
└── tsconfig.json        # TypeScript configuration
```

---

## 🌍 Model Agnostic Implementation

ScanLogic is designed to be **model-agnostic**. While it currently uses Google Gemini 1.5 Flash, the extraction logic is abstracted.

**How to switch models:**
1. **Abstraction**: The `handlePhoto` and `handleText` functions in `server.ts` use a standardized prompt and response schema.
2. **Implementation**: To use OpenAI (GPT-4o) or Anthropic (Claude 3.5), you simply need to swap the client initialization and the `generateContent` call.
3. **Prompting**: The system uses structured JSON output (`responseMimeType: "application/json"`), which is supported by most modern LLMs.

---

## 🏠 Self-Hosting Guide

To host ScanLogic on your own infrastructure:

1. **Prerequisites**:
   - Node.js 20+ installed.
   - A Supabase project (PostgreSQL + Storage).
   - A Telegram Bot Token (from [@BotFather](https://t.me/botfather)).
   - A Google Gemini API Key.

2. **Setup**:
   ```bash
   git clone <your-repo-url>
   npm install
   cp .env.example .env
   # Fill in your secrets in .env
   ```

3. **Deployment**:
   - **Docker**: Create a `Dockerfile` to containerize the Express server.
   - **Webhook**: Ensure your server has a public URL (via Ngrok for local testing or a domain for production) and set the Telegram webhook to `https://your-domain.com/api/telegram-webhook`.

---

## 📈 Scaling to Enterprise

For enterprise-grade deployments, ScanLogic can be scaled as follows:

1. **Architecture**: Move from a single Express server to a **Microservices** architecture.
   - **OCR Service**: Dedicated service for heavy image processing.
   - **API Gateway**: Manage authentication and rate limiting.
2. **Security**:
   - Implement **Enterprise SSO** via Supabase Auth (SAML/OIDC).
   - Use **VPC Peering** for database connections.
   - Add **Data Masking** for PII (Personally Identifiable Information) before sending data to AI models.
3. **Compliance**: Add audit logging for every document processed and implement data retention policies.
4. **Multi-Tenancy**: Update the database schema to support `organization_id` for segregated corporate data.

---

## 🔮 Product Expansion (Roadmap)

- **[ ] WhatsApp Integration**: Expand beyond Telegram to reach more users.
- **[ ] Multi-Currency Conversion**: Automatically convert all expenses to a base currency using real-time exchange rates.
- **[ ] Direct Bank Integration**: Connect to bank APIs to reconcile physical receipts with digital transactions.
- **[ ] Team Collaboration**: Shared folders for business teams to manage group expenses.
- **[ ] Advanced Analytics**: AI-driven insights on spending habits and budget optimization tips.
