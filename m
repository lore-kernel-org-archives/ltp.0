From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jan 2019 14:26:06 +0100
Subject: [LTP] [PATCH v2 2/3] ver_linux: Add lsb_release -a
In-Reply-To: <20190103132607.24930-1-pvorel@suse.cz>
References: <20190103132607.24930-1-pvorel@suse.cz>
Message-ID: <20190103132607.24930-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
---
 ver_linux | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ver_linux b/ver_linux
index bbc89987b..f083c0df8 100755
--- a/ver_linux
+++ b/ver_linux
@@ -19,6 +19,10 @@ if [ $? = 1 ]; then
    echo '/etc/issue:'
    cat /etc/issue 2> /dev/null
 fi
+if [ $? = 1 ]; then
+	echo 'lsb_release -a'
+	lsb_release -a 2> /dev/null
+fi
 
 echo
 echo 'uname:'
-- 
2.19.2

