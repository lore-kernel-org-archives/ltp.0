From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Jun 2021 10:12:00 +0200
Subject: [LTP] [PATCH 1/1] delete_module0{1,
 3}: Skip when kernel is locked down
In-Reply-To: <YNrFdXeCRXUko2Ua@pevik>
References: <20210629065836.20932-1-pvorel@suse.cz> <YNrFdXeCRXUko2Ua@pevik>
Message-ID: <CAASaF6wVbZ8GT549y3RXiTrXi3mwtFVK=-=RWtyJOK+1TasJCg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 29, 2021 at 9:02 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > Lockdown requires signed modules, otherwise tests fails with EPERM.
> > TCONF until we solve signing modules in LTP build.
>

Acked-by: Jan Stancek <jstancek@redhat.com>


> BTW up now only 4 tests are using tst_lockdown_enabled() check, but maybe
> it's a
> time to add flag .skip_on_lockdown, as docparse would benefit from it.
>

I guess we'll find more over time.


>
> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210629/aa3e9b00/attachment-0001.htm>
