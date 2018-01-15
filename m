From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Mon, 15 Jan 2018 10:49:21 +0900
Subject: [LTP] [PATCH 2/2] execltp: add rstrip to runtest_file
In-Reply-To: <20180104154527.GC25335@rei>
References: <1514181786-6677-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
 <1514181786-6677-3-git-send-email-daniel.sangorrin@toshiba.co.jp>
 <20180104154527.GC25335@rei>
Message-ID: <007401d38da3$100e88d0$302b9a70$@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Friday, January 05, 2018 12:45 AM
> To: Daniel Sangorrin
> Cc: ltp@lists.linux.it
> Subject: Re: [LTP] [PATCH 2/2] execltp: add rstrip to runtest_file
> 
> Hi!
> > Without an rstrip I was getting errors saying that the
> > runtest file syscalls didn't exist.
> >
> > Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> > ---
> >  execltp.in | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/execltp.in b/execltp.in
> > index 6d13ad1..2dcdf10 100755
> > --- a/execltp.in
> > +++ b/execltp.in
> > @@ -361,7 +361,7 @@ def main():
> >
> >              failed_subset = {}
> >
> > -            runtest_file = os.path.join(opts.ltp_dir, 'runtest', testsuite)
> > +            runtest_file = os.path.join(opts.ltp_dir, 'runtest', testsuite).rstrip()
> 
> I suppose that the problem here is that the fd.readlines() does include
> newlines at the end of the lines. But stripping it at the point we
> construct the paths seems to be a bit confusing to me.
> 
> What about something as:
> 
> diff --git a/execltp.in b/execltp.in
> index 6d13ad1d7..10b1f53f3 100755
> --- a/execltp.in
> +++ b/execltp.in
> @@ -309,7 +309,7 @@ def main():
>          # Default to scenarios also used by runltp.
>          fd = open(os.path.join(ltpdir, 'scenario_groups/default'), 'r')
>          try:
> -            args = fd.readlines()
> +            args = [l.strip() for l in fd.readlines()]
>          finally:
>              fd.close()
> 

Sorry for the late reply.
I tested your suggestion and it worked great.

Thanks,
Daniel





