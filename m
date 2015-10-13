From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Oct 2015 21:39:24 +0800
Subject: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in
	hugemmap02.c
In-Reply-To: <20151013105318.GA26969@rei.suse.cz>
References: <1444647235-3041-1-git-send-email-liwang@redhat.com>
 <20151012182924.GB24472@rei.suse.cz>
 <CAEemH2eZKj6USX5nmVrRQ7QVykOrYZ9c=BhVPASW3=YTatZ0zA@mail.gmail.com>
 <CAEemH2dGJE+zhHH83yeNzAW=A0H8o0T-D3nH=yc1Xt5sN0m2TQ@mail.gmail.com>
 <20151013105318.GA26969@rei.suse.cz>
Message-ID: <CAEemH2f_fc2RA3hDn7MxTF_o+geXVVx57W41YNHbqp+tkmgVYA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Tue, Oct 13, 2015 at 6:53 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > okay, seems you are right. I tried and achieved another one,  following
> > code test pass on my s390x system.
> > -----------------------------------------
> > int range_is_mapped(unsigned long low, unsigned long high)
> > {
> >     FILE *f = SAFE_FOPEN(NULL, "/proc/self/maps", "r");
>
> If we start to use SAFE_MACROS() here we have to pass the cleanup
> callback to the range_is_mapped() as a first parameter so that we can
> pass correct cleanup callback to the SAFE_MACROS().
>

ok, now I prefer to use fopen()/fclose() to keep simple.


>
> >     char buf[512];
> >
> >     while (!feof(f)) {
> >         unsigned long start, end;
> >         int ret;
> >
> >         ret = fscanf(f, "%lx-%lx %[^\n]%*c]", &start, &end, buf);
>
> You can do even better with:
>
>                 ret = fscanf(f, "%lx-%lx %*[^\n]\n", &start, &end);
>

great!


>
> Which says read two long ints and then ignore everything until the end
> of line.
>
> You could have ommited the last '\n' in the format string, but then you
> would need to exit the loop when the fscanf() returns -1 since the
> feof() would not exit the loop since there would still be the last
> newline in the buffer after we read the last line...
>

ok, agreed. I will sent V3.

thanks for reviewing the patch.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151013/d3351495/attachment.html>
