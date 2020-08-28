From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Aug 2020 14:40:52 +0800
Subject: [LTP] [PATCH v2] travis: Use centos:7 instead of centos:6
In-Reply-To: <716a3ffc-fa20-01df-a63f-86a5a50239af@cn.fujitsu.com>
References: <20200825064706.GA7135@x230>
 <1598339667-24948-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eS0PS=hmpiWBzkfBQ3cO4K2u2bVgcO5ZK4fz9N+xg7uQ@mail.gmail.com>
 <716a3ffc-fa20-01df-a63f-86a5a50239af@cn.fujitsu.com>
Message-ID: <CAEemH2faKH1xUAx7GAS_01UYwZfya3AbJj12fqzOoZ6=OTJZrQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

Sorry for the delay. I guess many Developers(European or North America) are
busy with the LPC(Linux Plumbers Conference) recently. please
keep patience:).

Btw, there is a new build error on CentOS7(seems unrelated to your patch):

  /usr/src/ltp/lib/tst_af_alg.c:205:21: error: 'ALG_SET_AEAD_ASSOCLEN'
undeclared (first use in this function)
  2084 cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;

https://travis-ci.com/github/wangli5665/ltp/jobs/378677988


On Fri, Aug 28, 2020 at 11:22 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi Li, Petr
>
> Does have anything block this patch? Or, we should listen some advise
> from Jan and Cyril?
>
> ps: Also, ALG_SET_AEAD_ASSOCLEN undefined error patch needs to be reviewed.
>
> Best Regards
> Yang Xu
> >
> >
> > On Tue, Aug 25, 2020 at 3:14 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com
> > <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> >
> >     I have this idea when I meet ALG_SET_AEAD_ASSOCLEN undefined error
> >     on centos7.
> >     It is more friendly for centos7 user and more meaningful. centos6 is
> >     outdated
> >     and we should drop it.
> >
> >     Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com
> >     <mailto:xuyang2018.jy@cn.fujitsu.com>>
> >
> > Acked-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>
> >
> >     ---
> >       .travis.yml | 2 +-
> >       1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >     diff --git a/.travis.yml b/.travis.yml
> >     index e8e3189af..3c5ff99b7 100644
> >     --- a/.travis.yml
> >     +++ b/.travis.yml
> >     @@ -44,7 +44,7 @@ matrix:
> >                 compiler: clang
> >
> >               - os: linux
> >     -          env: DISTRO=centos:6 TREE=out
> >     +          env: DISTRO=centos:7 TREE=out
> >                 compiler: gcc
> >
> >               - os: linux
> >     --
> >     2.23.0
> >
> >
> >
> >
> >     --
> >     Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> >
> >
> > --
> > Regards,
> > Li Wang
>
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200828/a14a5dcb/attachment.htm>
