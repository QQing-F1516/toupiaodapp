<template>
  <div class="voting-container">
    <div class="card">
      <div class="header">
        <div class="status-badge" :class="{ connected: isConnected }">
          <span class="status-bot"></span>
          {{ isConnected ? '已连接' : '未连接' }}
        </div>
        <div class="account-badge">
          0x3445678787543456
        </div>
      </div>
      <!-- 标题 -->
      <h1 class="title">区块链投票</h1>
      <p class="subtitle">去中心化、透明、不可篡改</p>
      <!-- 候选人列表票数 -->
      <div class="section">
        <div class="section-header">
          <h2>当前票数</h2>
        </div>
        <div v-if="loading" class="loading-state">
          <div class="spinner"></div>
          <span>加载数据中</span>
        </div>
        <div v-else class="candidates-list">
          <div v-for="candidate in candidates" :key="candidate.id" class="candidates-row">
            <span class="candidates-name">{{ candidate.name }}</span>
            <div class="vote-count-pill">{{ candidate.voteCount }}票</div>
          </div>
        </div>
      </div>
      <!-- 投票操作区 -->
      <div class="section vote-action-area">
        <div class="section-header">
          <h2>我要投票</h2>
        </div>
        <div class="form-group">
          <select v-model="selectedCandidate" class="modern-select">
            <option value="" disabled>选择候选人......</option>
            <option v-for="candidate in candidates" :key="candidate.id" :value="candidate.id">{{ candidate.name }}
            </option>
          </select>
        </div>
        <button class="btn-primary">确认投票</button>
        <div class="footer-action">
          <button class="btn-outline">连接MetaMask钱包</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
const isConnected = ref(false);
const loading = ref(false);
const selectedCandidate = ref('');
const candidates = ref([
  { id: 1, name: 'Alice', voteCount: 10 },
  { id: 2, name: 'Bob', voteCount: 20 },
  { id: 3, name: 'Charlie', voteCount: 30 }
]);
</script>

<style scoped>
.voting-container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f3f4f6;
  padding: 20px;
}

.card {
  background: #ffffff;
  width: 100%;
  max-width: 480px;
  box-shadow: 0px 10px 25px -5px rgba(0, 0, 0, 0.05), 0px 8px 10px -6px rgba(0, 0, 0, 0.01);
  padding: 32px;
  border-radius: 20px;
  transition: transform 0.2s ease;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.status-badge {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 13px;
  font-weight: 600;
  color: #6b7280;
  background: #f9fafb;
  padding: 6px 12px;
  border-radius: 999px;
  border: 1px solid #e5e7eb;
}

.status-badge.connected {
  color: #059669;
  background: #ecfdf5;
  border-color: #d1fae5;
}

.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: #d1fae5;
}

.connected .status-dot {
  background: #10b981;
  box-shadow: 0 0 0 2px rgba(16, 185, 129, 0.2);
}

.account-badge {
  font-size: 12px;
  color: #6b7280;
  background: #f3f4f6;
  padding: 4px 8px;
  border-radius: 6px;
}

.title {
  font-size: 28px;
  font-weight: 800;
  color: #111827;
  text-align: center;
  margin: 0 0 8px 0;
  letter-spacing: -0.02em;
}

.subtitle {
  text-align: center;
  color: #6b7280;
  font-size: 14px;
  margin-bottom: 32px;
}

.section {
  margin-bottom: 24px;
}

.section-header h2 {
  font-size: 14px;
  letter-spacing: 0.05em;
  color: #9ca3af;
  font-weight: 700;
  margin-bottom: 12px;
}

.loading-state {
  text-align: center;
  padding: 20px;
  color: #9ca3af;
  font-size: 14px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.spinner {
  width: 20px;
  height: 20px;
  border: 2px solid #e5e7eb;
  border-top-color: #2563eb;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

.loading-state {
  .spinner {
    width: 20px;
    height: 20px;
    border: 2px solid #59576b;
    border-top-color: #2652eb;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;
  }
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.candidates-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.candidates-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  background: #f9fafb;
  border: 1px solid #f3f4f6;
  border-radius: 12px;
  transition: all 0.2s;
}

.candidates-row:hover {
  background: #f3f4f6;
  transform: translateX(4px);
}

.candidates-name {
  font-weight: 600;
  color: #374151;
  font-size: 16px;
}

.vote-count-pill {
  background: #ffffff;
  padding: 6px 12px;
  border-radius: 999px;
  font-size: 14px;
  font-weight: 700;
  color: #2652eb;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
  border: 1px solid #e5e7eb;
}

.modern-select {
  width: 100%;
  padding: 14px;
  border: 1px solid #e5e7eb;
  border-radius: 12px;
  font-size: 16px;
  color: #1f2937;
  background-color: #ffffff;
  outline: none;
  transition: border-color 0.5s ease;
  cursor: pointer;
  margin-bottom: 16px;
  appearance: none;
  -webkit-appearance: none;
}

.modern-select:focus {
  border-color: #2563eb;
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.modern-select:hover {
  border-color: #2563eb;
  box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
}

.btn-primary {
  width: 100%;
  padding: 16px;
  background-color: #2563eb;
  color: white;
  border: none;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  box-shadow: 0 4px 6px -1px rgba(37, 99, 235, 0.2);
}

.btn-primary:hover:not(:disabled) {
  background-color: #1d4ed8;
  transform: translateY(-1px);
  box-shadow: 0 6px 8px -1px rgba(37, 99, 235, 0.3);
}

.btn-primary:disabled {
  background-color: #9ca3af;
  cursor: not-allowed;
  box-shadow: none;
}

.footer-action {
  margin-top: 24px;
  padding-top: 24px;
  border-top: 1px solid #f3f4f6;
}

.btn-outline {
  width: 100%;
  padding: 16px;
  background: transparent;
  color: #2563eb;
  border: 2px solid #eff6ff;
  border-radius: 12px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-outline:hover {
  border-color: #2563eb;
  background-color: #eff6ff;
}
</style>