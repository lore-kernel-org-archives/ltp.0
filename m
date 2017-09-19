From: Sandeep Patil <sspatil@google.com>
Date: Tue, 19 Sep 2017 11:26:18 -0700
Subject: [LTP] LTP release and code freeze
In-Reply-To: <20170919084849.GA14328@rei>
References: <20170919084849.GA14328@rei>
Message-ID: <20170919182618.GL18273@sspatil-macbookpro.roam.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Sep 19, 2017 at 10:48:49AM +0200, Cyril Hrubis wrote:
> Hi!
> We are getting closer to a release, here is the status as I see it.
> 
> Blockers:
> 
> * thp01 failing on newer kernels
>   - I'm waiting for v4 from Ritchie
> 
> * utimensat01 failing on stable kernels
>   - That thread on ML is kind of stuck,
>     I guess that we will have to accept
>     both errors for some range of kernels
> 
> 
> Nice to have:
> 
> * The clone09 patch to disable it on old kernels looks sane to me
>    - I will merge that one
> 
> * CVE synchronization library
>    - depends if Ritchie can fix it fast enough
> 
> * The .needs_rofs patchset looks good to me as well I guess that
>   it's safe enough to be included in the release as well

Yes, thanks for this. It unblocks a bunch of tests for us in Android.
I'll respond with a small list to your question in the patch thread.

> 
> 
> Is there anything else I've missing?

FWIW, I will work to merge the release and report any new, discovered
failures on Android and track to fix it post-release. If you want me (us) to
do the same on an -rc, let me know.

- ssp



> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
