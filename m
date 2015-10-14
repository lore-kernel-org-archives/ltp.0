From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Oct 2015 15:06:55 +0800
Subject: [LTP] Fwd: [PATCH v3] mem/hugetlb: shift an empty region to use in
	hugemmap02.c
In-Reply-To: <CAEemH2dRZ11NJSrpNPvR-xA_C_ULsqdObWVFSGBZi-22fRGOcw@mail.gmail.com>
References: <1444745490-9044-1-git-send-email-liwang@redhat.com>
 <20151013164030.GB27888@rei>
 <CAEemH2dRZ11NJSrpNPvR-xA_C_ULsqdObWVFSGBZi-22fRGOcw@mail.gmail.com>
Message-ID: <CAEemH2d-zx8X7uhCsGAOQYZGADGA36tfytekeYsjU+=ydzXAmQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

cc' ltp@lists.linux.it

---------- Forwarded message ----------
From: Li Wang <liwang@redhat.com>
Date: Wed, Oct 14, 2015 at 2:50 PM
Subject: Re: [PATCH v3] mem/hugetlb: shift an empty region to use in
hugemmap02.c
To: Cyril Hrubis <chrubis@suse.cz>

Hi,

On Wed, Oct 14, 2015 at 12:40 AM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> >  int main(int ac, char **av)
> >  {
> > @@ -127,15 +130,29 @@ int main(int ac, char **av)
> >                       addrlist[i] = addr;
> >               }
> >
> > +             while (range_is_mapped(low_addr, low_addr + 0x1000) == 1) {
>
>                                                           ^ + map_sz?
>

oops! I just focus on s390x before, it should be map_sz.


>
> > +                     low_addr = low_addr + 0x10000000;
> > +
> > +                     if (low_addr < LOW_ADDR)
> > +                             tst_brkm(TBROK | TERRNO, cleanup,
> > +                                             "no empty region to use");
> > +             }
>
> Well, if we do not call tst_brkm() in the range_is_mapped() function we
> should check here that the return value wasn't -1 and exit the test
> accordingly...
>

hmm, check the return value here is not good, that would make confused in
range_is_mapped() used. I'd like to handle the situation by the function
itself.

-----
int range_is_mapped(unsigned long low, unsigned long high)
{
    FILE *fp;

    fp = fopen("/proc/self/maps", "r");
    if (fp == NULL)
        tst_brkm(TBROK | TERRNO, tst_exit, "Failed to open
/proc/self/maps.");

    while (!feof(fp)) {
        unsigned long start, end;
        int ret;

        ret = fscanf(fp, "%lx-%lx %*[^\n]\n", &start, &end);
        if (ret != 2) {
            fclose(fp);
            tst_brkm(TBROK | TERRNO, tst_exit, "Couldn't parse
/proc/self/maps line.");
        }

        if ((start >= low) && (start < high)) {
            fclose(fp);
            return 1;
        }
        if ((end >= low) && (end < high)) {
            fclose(fp);
            return 1;
        }
    }

    fclose(fp);
    return 0;
}


any problem?


-- 
Regards,
Li Wang
Email: liwang@redhat.com



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151014/81ed9953/attachment-0001.html>
