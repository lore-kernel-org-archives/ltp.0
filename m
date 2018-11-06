From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Nov 2018 17:25:22 +0800
Subject: [LTP] [RFC PATCH 0/2] Cleanup runtests containing duplicate
	definitions
In-Reply-To: <20181105190134.GA12879@dell5510>
References: <20181015201819.10868-1-pvorel@suse.cz>
 <20181105114301.GA3591@dell5510>
 <CAEemH2fxHBmWmuj314ZdB+E2i2wXBtOg40SrSgt2Vxtqcns=0Q@mail.gmail.com>
 <863155656.69419841.1541430302026.JavaMail.zimbra@redhat.com>
 <20181105190134.GA12879@dell5510>
Message-ID: <CAEemH2cndLR3ZkF2MJdc7+SVxtKiYhepj=_fUAstgXH2e8bk7w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 6, 2018 at 3:01 AM, Petr Vorel <pvorel@suse.cz> wrote:

> Hi Jan, Li,
>
> > > Jan, did we internal ltp-lite take reference from the ltplite file?
>
> > Probably only at the beginning, when original author of beaker test
> > forked ltplite runtest file. I've been using syscalls/other runtest
> > files, since those are more up to date.
>
> > > I wanna
> > > know how do we customize our internal ltp-lite testcases.
>
> > syscalls + cherry-picked tests from other runtest files.
>
> Is it problematic for you to remove these runtest files?
>

I think we're OK to remove that in upstream.

> Hope not, but if yes, please let me know. I'll wait for your ack before
> removing it.
>
> Kind regards,
> Petr
>



-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181106/db4c71ad/attachment.html>
