From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jun 2020 19:40:38 +0800
Subject: [LTP] [PATCH 1/2] cgroup: Fix build with -Werror=return-type
In-Reply-To: <20200622092213.GA27392@dell5510>
References: <20200622074314.22098-1-petr.vorel@suse.com>
 <CAEemH2cz9s71E+VidezUAfYGarOzgpPTf0VucY+OYCYmjBjTGQ@mail.gmail.com>
 <20200622092213.GA27392@dell5510>
Message-ID: <CAEemH2dOpFaJY0DCLwULGBpf6ENEouirRuA2pOK-MzQvfyKR=A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 22, 2020 at 5:22 PM Petr Vorel <pvorel@suse.com> wrote:

> Hi Li,
>
> > >         tst_brk(TCONF, "Cgroup is not configured");
> > > +       return TST_CGROUP_V1; /* fix -Werror=return-type */
>
>
> > This return looks strange since it will never go to here.
>
> > How about this?
>
> I'm sorry, I overlooked your mail and push whole patchset.
>
> LGTM, feel free to merge.
> Tested-by: Petr Vorel <pvorel@suse.cz>
>

This is correct, I go back to this v1 way and pushed. Thanks Petr!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200622/7d1196ab/attachment-0001.htm>
