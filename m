From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Jan 2018 16:45:27 +0100
Subject: [LTP] [PATCH 2/2] execltp: add rstrip to runtest_file
In-Reply-To: <1514181786-6677-3-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1514181786-6677-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
 <1514181786-6677-3-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20180104154527.GC25335@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Without an rstrip I was getting errors saying that the
> runtest file syscalls didn't exist.
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  execltp.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/execltp.in b/execltp.in
> index 6d13ad1..2dcdf10 100755
> --- a/execltp.in
> +++ b/execltp.in
> @@ -361,7 +361,7 @@ def main():
>  
>              failed_subset = {}
>  
> -            runtest_file = os.path.join(opts.ltp_dir, 'runtest', testsuite)
> +            runtest_file = os.path.join(opts.ltp_dir, 'runtest', testsuite).rstrip()

I suppose that the problem here is that the fd.readlines() does include
newlines at the end of the lines. But stripping it at the point we
construct the paths seems to be a bit confusing to me.

What about something as:

diff --git a/execltp.in b/execltp.in
index 6d13ad1d7..10b1f53f3 100755
--- a/execltp.in
+++ b/execltp.in
@@ -309,7 +309,7 @@ def main():
         # Default to scenarios also used by runltp.
         fd = open(os.path.join(ltpdir, 'scenario_groups/default'), 'r')
         try:
-            args = fd.readlines()
+            args = [l.strip() for l in fd.readlines()]
         finally:
             fd.close()


-- 
Cyril Hrubis
chrubis@suse.cz
