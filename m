From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 09:17:59 +0200
Subject: [LTP] [PATCH v2] travis: Use centos:7 instead of centos:6
In-Reply-To: <CAEemH2dvu8+GOfd2EHVFuL=KNCQdQyO3xTKz3OXtLqOL_u+7kQ@mail.gmail.com>
References: <20200825064706.GA7135@x230>
 <1598339667-24948-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eS0PS=hmpiWBzkfBQ3cO4K2u2bVgcO5ZK4fz9N+xg7uQ@mail.gmail.com>
 <716a3ffc-fa20-01df-a63f-86a5a50239af@cn.fujitsu.com>
 <CAEemH2faKH1xUAx7GAS_01UYwZfya3AbJj12fqzOoZ6=OTJZrQ@mail.gmail.com>
 <CAEemH2dvu8+GOfd2EHVFuL=KNCQdQyO3xTKz3OXtLqOL_u+7kQ@mail.gmail.com>
Message-ID: <20200828071759.GA24100@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Fri, Aug 28, 2020 at 2:40 PM Li Wang <liwang@redhat.com> wrote:

> > Hi Xu,

> > Sorry for the delay. I guess many Developers(European or North
> > America) are busy with the LPC(Linux Plumbers Conference) recently. please
> > keep patience:).
+1 :)

> > Btw, there is a new build error on CentOS7(seems unrelated to your patch):

> >   /usr/src/ltp/lib/tst_af_alg.c:205:21: error: 'ALG_SET_AEAD_ASSOCLEN'
> > undeclared (first use in this function)
> >   2084 cmsg->cmsg_type = ALG_SET_AEAD_ASSOCLEN;


> Ah, seems you have sent a patch for that, I will help to review soon.
> http://lists.linux.it/pipermail/ltp/2020-August/018651.html
Looking into that.

Kind regards,
Petr
