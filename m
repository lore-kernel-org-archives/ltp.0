From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 09:08:15 +0200
Subject: [LTP] [PATCH] syscalls/fanotify: Fix running tests in a loop
In-Reply-To: <20210714180840.160798-1-amir73il@gmail.com>
References: <20210714180840.160798-1-amir73il@gmail.com>
Message-ID: <YO/e3wcY8oXyFCO5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> Both fanotify19 and fanotify18 leaked fds when run in a loop.
> fanotify19 was not checking child process exit status correctly
> which resulted in random failures.

Thanks for a quick fix!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI both fixes prolonged running for about 100% (comparing with runs on master
which don't fail). Of course, that's not a problem at all, it's just interesting
for me how simple closing of file descriptor can be expensive.

Kind regards,
Petr

# time ./fanotify19 -i40

Summary:
passed   360
failed   0
broken   0
skipped  0
warnings 0

real	0m0,871s
user	0m0,028s
sys	0m0,116s

vs.

Summary:
passed   360
failed   0
broken   0
skipped  0
warnings 0

real	0m0,387s
user	0m0,016s
sys	0m0,122s

# time ./fanotify19 -i10
Summary:
passed   160
failed   0
broken   0
skipped  0
warnings 0

real	0m0,436s
user	0m0,032s
sys	0m0,128s

vs.

Summary:
passed   160
failed   0
broken   0
skipped  0
warnings 0

real	0m0,876s
user	0m0,052s
sys	0m0,105s
