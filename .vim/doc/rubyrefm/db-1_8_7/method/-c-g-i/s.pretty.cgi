kind=defined
names=pretty
visibility=public

--- pretty(string, shift = "  ") -> String

HTML ��ʹ֤˸��䤹������������ʸ������֤��ޤ���

@param string HTML ����ꤷ�ޤ���

@param shift ����ǥ�Ȥ˻��Ѥ���ʸ�������ꤷ�ޤ����ǥե���Ȥ�Ⱦ�Ѷ�����ĤǤ���

�㡧
        require "cgi"

        print CGI.pretty("<HTML><BODY></BODY></HTML>")
          # <HTML>
          #   <BODY>
          #   </BODY>
          # </HTML>

        print CGI.pretty("<HTML><BODY></BODY></HTML>", "\t")
          # <HTML>
          #         <BODY>
          #         </BODY>
          # </HTML>
