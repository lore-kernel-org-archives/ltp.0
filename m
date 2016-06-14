From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Jun 2016 22:37:29 +0800
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
Message-ID: <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

On Tue, Jun 14, 2016 at 7:27 PM, Jan Stancek <jstancek@redhat.com> wrote:
> This patch adds 2 new functions that both parse data
> from /proc/meminfo.

It is a good proposal, but the achieved function seems a little bit
narrow for ltp-lib. Can we
rename the tst_mem.h to tst_proc.h, and makes the whole items of
procfs could be readable via the same interfaces? And the strict
parameter is not necessary for the function i think.

How about something like this?

-----------------------------------------
long read_proc(char *path, char *item)
{
    FILE *fp;
    char line[BUFSIZ], buf[BUFSIZ];
    long val;

    fp = fopen(path, "r");
    if (fp == NULL)
        tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", path);

    while (fgets(line, BUFSIZ, fp) != NULL) {
        if (sscanf(line, "%64s %ld", buf, &val) == 2)
            if (strcmp(buf, item) == 0) {
                fclose(fp);
                return val;
            }
        continue;
    }
    fclose(fp);

    tst_res(TINFO, "cannot find \"%s\" in %s", item, path);

    return -1;
}

long tst_read_meminfo(char *item)
{

    return read_proc("/proc/meminfo", item);
}

long tst_read_self_status(char *item)
{
    return read_proc("/proc/self/status", item);
}

// we can extend this interface easily by uniform prototype
long tst_read_blablabla(char *item)
{
    return read_proc("/proc/blablabla...", item);
}
...

long tst_get_avail_mem(void)
{
       long mem_available;

       mem_available = tst_read_meminfo("memavailable:");
       if (mem_available == -1) {
               mem_available = tst_read_meminfo("memfree:");
               mem_available += tst_read_meminfo("cached:");
       }

       return mem_available;
}


Regards,
Li Wang
