From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Jun 2018 15:05:58 +0200
Subject: [LTP] [PATCH v3] tst_test.sh: achieve TST_RETRY_FUNC function
	in shell
In-Reply-To: <20180517062919.13018-1-liwang@redhat.com>
References: <20180517062919.13018-1-liwang@redhat.com>
Message-ID: <20180612130558.docr3b7fffimqqoq@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> The commit c2ce4df67d(include: add an exponential backoff macro for
> function retry) involves a new MACRO for function retry in C code,
> here achieve it in shell lib and gives a introduction in LTP documents.

> Signed-off-by: Li Wang <liwang@redhat.com>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> ---
Thanks for your patch. Pushed with minor fix bellow + updated wiki.


Kind regards,
Petr

+++ testcases/lib/tst_test.sh
@@ -189,7 +189,7 @@ TST_RETRY_FN_EXP_BACKOFF()
 TST_RETRY_FUNC()
 {
 	if [ $# -ne 2 ]; then
-		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 2 parameters"
+		tst_brk TBROK "TST_RETRY_FUNC expects 2 parameters"
 	fi
 
 	TST_RETRY_FN_EXP_BACKOFF "$1" "$2" 1
