# vscode에서 ctrl+shift+p -> 인터프리터 선택(llm)
# 실행 ctrl+j : powsershell 터미널 -> command prompt에서 streamlit run 2_streamlit.py
import streamlit as st
st.set_page_config(page_title="첫번째 데모")

st.title("나의 첫 stream 웹")
st.header("웹 앱을 만들기 위한 강력하고 사용하기 쉬운 라이브러리")
st.subheader("Streamlit에 오신 것을 환영")

st.text('text')
st.write('write')
st.markdown("-----")
message = st.text_area("요약 글을 입력하세요.")

if st.button('요약'):
    st.info('버튼 클릭!')

if prompt := st.chat_input('쳇입력 받기'):
    st.chat_message("user").write(prompt)
    st.chat_message("assistant").write(prompt)
