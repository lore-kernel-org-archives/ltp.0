From: Li Wang <liwang@redhat.com>
Date: Tue, 29 Jun 2021 18:32:10 +0800
Subject: [LTP] [PATCH 1/1] delete_module0{1,
 3}: Skip when kernel is locked down
In-Reply-To: <YNrFdXeCRXUko2Ua@pevik>
References: <20210629065836.20932-1-pvorel@suse.cz> <YNrFdXeCRXUko2Ua@pevik>
Message-ID: <CAEemH2dTEC9QNhs4JZtiR33U9m=nyfQOiZ2u=DrMrXkVvcrRDw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 29, 2021 at 3:02 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > Lockdown requires signed modules, otherwise tests fails with EPERM.
> > TCONF until we solve signing modules in LTP build.
> BTW up now only 4 tests are using tst_lockdown_enabled() check, but maybe
> it's a
> time to add flag .skip_on_lockdown, as docparse would benefit from it.
>

Make sense!

Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210629/73dd714b/attachment.htm>
