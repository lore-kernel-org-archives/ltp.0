From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Aug 2016 17:34:18 +0200
Subject: [LTP] [PATCH v2 2/2] network/nfs05: rewrite the test,
 make use of new library
In-Reply-To: <1467129655-9110-2-git-send-email-alexey.kodanev@oracle.com>
References: <1467129655-9110-1-git-send-email-alexey.kodanev@oracle.com>
 <1467129655-9110-2-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20160816153417.GF25540@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  tst_resm TINFO "start nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM"
> -ROD nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM
> +TMPDIR=$(pwd) nfs05_make_tree -d $DIR_NUM -f $FILE_NUM -t $THREAD_NUM

Hmm, the tst_tmpdir is created and mounted in the nfs_setup right?

Why can't we just let the nfs05_make_tree work with current
directory and omit the needs_tmpdir = 1 from it's source? It's not like
the nfs05_make_tree binary is supposed to be executed directly, so it's
OK if it starts to create files in PWD.

-- 
Cyril Hrubis
chrubis@suse.cz
