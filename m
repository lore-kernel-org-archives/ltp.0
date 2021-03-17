From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 17:24:29 +0800
Subject: [LTP] [RFC PATCH 1/1] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <YFHI5KEAI7HpgPzm@pevik>
References: <20210317083347.9791-1-pvorel@suse.cz> <YFHI5KEAI7HpgPzm@pevik>
Message-ID: <CAEemH2dp1AJBbOu9GS0Yt4VjqVpP7z+yH0QSZmZyaC=8nDKTSw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, Mar 17, 2021 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> ...
> > +++ b/doc/maintainer-patch-review-checklist.txt
> > @@ -0,0 +1,32 @@
> > +# Maintainer Patch Review Checklist
> > +
> > +Patchset should be tested locally and ideally also in maintainer's fork
> in
> > +https://travis-ci.org/[Travis CI].
> > +
> > +Commit messages should have
> > +
> > +* author's `Signed-off-by` tag
> > +* committer's `Reviewed-by` or `Signed-off-by` tag
> > +* check also mailing lists for other reviewers / testers
>
> Also add:
> Please update patchset status in
> https://patchwork.ozlabs.org/project/ltp/list/[LTP patchwork].
>

Also Add:

Please update LTP WIKI if touch doc/*.txt.
https://github.com/linux-test-project/ltp.wiki.git

Otherwise, LGTM.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210317/13b53ac9/attachment.htm>
