From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Oct 2019 17:55:59 +0800
Subject: [LTP] [PATCH v5 3/5] shell: Add timeout shell API tests
In-Reply-To: <20191011133129.GA23391@dell5510>
References: <20191011095442.10541-1-pvorel@suse.cz>
 <20191011095442.10541-4-pvorel@suse.cz>
 <1570797394.4238.7.camel@suse.de> <20191011125413.GA30000@dell5510>
 <20191011125648.GF2591@rei> <20191011133129.GA23391@dell5510>
Message-ID: <CAEemH2d7SG0vGp91TPVPuEBV0zD_m8gEk9WtpQrN0Yo2VCytFg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Oct 11, 2019 at 9:31 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > > timeout02 1 TCONF: LTP_TIMEOUT_MUL must be number >= 1! (0)
> > > BTW I wonder if TBROK shouldn't be used instead of TCONF.
> > > Anybody strong opinion?
>
> > If we fail to run a test because user passed wrong input data it has to
> > be TBROK because TCONF can end up unnoticed.
> +1.
>
> I'd like to merge v5 with following diff:
> Please let me know if anything else is problematic.
>

Thanks for your work Petr!
For patchset:
    Tested-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191012/4a38de5d/attachment.htm>
