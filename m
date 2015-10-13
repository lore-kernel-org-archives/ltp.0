From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Oct 2015 18:15:23 +0800
Subject: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in
	hugemmap02.c
In-Reply-To: <CAEemH2eZKj6USX5nmVrRQ7QVykOrYZ9c=BhVPASW3=YTatZ0zA@mail.gmail.com>
References: <1444647235-3041-1-git-send-email-liwang@redhat.com>
 <20151012182924.GB24472@rei.suse.cz>
 <CAEemH2eZKj6USX5nmVrRQ7QVykOrYZ9c=BhVPASW3=YTatZ0zA@mail.gmail.com>
Message-ID: <CAEemH2dGJE+zhHH83yeNzAW=A0H8o0T-D3nH=yc1Xt5sN0m2TQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Tue, Oct 13, 2015 at 1:39 PM, Li Wang <liwang@redhat.com> wrote:

> Hi,
>
> On Tue, Oct 13, 2015 at 2:29 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
>
>> Hi!
>> Generall idea looks good, a few comments below.
>>
>> > +/* MMAP */
>> > +int range_is_mapped(unsigned long low, unsigned long high)
>> >  #endif
>> > diff --git a/testcases/kernel/mem/lib/mem.c
>> b/testcases/kernel/mem/lib/mem.c
>> > index 118b6c0..e0e1bdf 100644
>> > --- a/testcases/kernel/mem/lib/mem.c
>> > +++ b/testcases/kernel/mem/lib/mem.c
>> > @@ -1113,3 +1113,46 @@ void update_shm_size(size_t * shm_size)
>> >               *shm_size = shmmax;
>> >       }
>> >  }
>> > +
>> > +int range_is_mapped(unsigned long low, unsigned long high)
>> > +{
>> > +     FILE *f;
>> > +     int MAPS_BUF_SZ = 4096;
>> > +     char line[MAPS_BUF_SZ];
>> > +     char *tmp;
>> > +
>> > +     f = fopen("/proc/self/maps", "r");
>> > +     if (!f) {
>> > +             printf("Failed to open /proc/self/maps.\n");
>>                 ^
>>                 should rather be tst_resm(TWARN, );
>>
>
> ok. looks like using
>     FILE * f = SAFE_FOPEN(NULL, "/proc/self/maps", "r");
> is better than above.
>
>
>> > +             return -1;
>> > +     }
>> > +
>> > +     while (1) {
>> > +             unsigned long start, end;
>> > +             int ret;
>> > +
>> > +             tmp = fgets(line, MAPS_BUF_SZ, f);
>> > +             if (!tmp)
>> > +                     break;
>> > +
>> > +             ret = sscanf(line, "%lx-%lx", &start, &end);
>> > +             if (ret != 2) {
>> > +                     printf("Couldn't parse /proc/self/maps line:
>> %s\n",
>> > +                                     line);
>>                         ^
>>                         here as well
>>
>
> ok.
>
>
>> > +                     fclose(f);
>> > +                     return -1;
>> > +             }
>>
>> Why don't you just use fscanf()? It doesn't make sense to read the line
>> into the buffer and then sscanf() the values.
>>
>
okay, seems you are right. I tried and achieved another one,  following
code test pass on my s390x system.
-----------------------------------------
int range_is_mapped(unsigned long low, unsigned long high)
{
    FILE *f = SAFE_FOPEN(NULL, "/proc/self/maps", "r");

    char buf[512];

    while (!feof(f)) {
        unsigned long start, end;
        int ret;

        ret = fscanf(f, "%lx-%lx %[^\n]%*c]", &start, &end, buf);
        if (ret != 3) {
            tst_resm(TWARN | TERRNO, "Couldn't parse /proc/self/maps
line.");
            SAFE_FCLOSE(NULL, f);
        }

        if ((start >= low) && (start < high)) {
            SAFE_FCLOSE(NULL, f);
            return 1;
        }
        if ((end >= low) && (end < high)) {
            SAFE_FCLOSE(NULL, f);
            return 1;
        }
    }

    SAFE_FCLOSE(NULL, f);
    return 0;
}

so, which one is better?  I will format patch V3 when getting some
proposals.

cc' jstancek@ if has some good idea.


> hmm, we need to read the '/proc/self/maps' line by line, It easy to use fgets()
> to get each line in and then sscanf() that.
>
> fscanf() will never read the newline at the end of the first line. So
> when it is called the second time, it will fail (returning 0, not EOF) and
> read nothing, leaving the [start, end] unchanged.
> maybe I don't know if fscanf() could achieve that also?
>
> so what about something like:
> --------------------------------------
> int range_is_mapped(unsigned long low, unsigned long high)
> {
>     FILE *f = SAFE_FOPEN(NULL, "/proc/self/maps", "r");
>
>     int MAPS_BUF_SZ = 4096;
>     char line[MAPS_BUF_SZ];
>
>     while (fgets(line, MAPS_BUF_SZ, f)) {
>         unsigned long start, end;
>         int ret;
>
>         ret = sscanf(line, "%lx-%lx", &start, &end);
>         if (ret != 2) {
>             tst_resm(TWARN | TERRNO, "Couldn't parse /proc/self/maps
> line.");
>             SAFE_FCLOSE(NULL, f);
>         }
>
>         if ((start >= low) && (start < high)) {
>             SAFE_FCLOSE(NULL, f);
>             return 1;
>         }
>         if ((end >= low) && (end < high)) {
>             SAFE_FCLOSE(NULL, f);
>             return 1;
>         }
>     }
>
>     SAFE_FCLOSE(NULL, f);
>     return 0;
> }
>
>
>
>> > +             if ((start >= low) && (start < high)) {
>> > +                     fclose(f);
>> > +                     return 1;
>> > +             }
>> > +             if ((end >= low) && (end < high)) {
>> > +                     fclose(f);
>> > +                     return 1;
>> > +             }
>> > +     }
>> > +
>> > +     fclose(f);
>> > +     return 0;
>> > +}
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>>
>
>
>
> --
> Regards,
> Li Wang
> Email: liwang@redhat.com
>



-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151013/6ec80a51/attachment.html>
