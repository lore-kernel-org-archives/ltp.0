From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Jul 2019 18:19:27 +0800
Subject: [LTP] [PATCH v4] Add a regression test for CVE-2017-1000380
In-Reply-To: <20190711141026.14705-1-mmoese@suse.de>
References: <20190711141026.14705-1-mmoese@suse.de>
Message-ID: <CAEemH2cjr23TZUDNLAt2Vvk03W8sHNy+eaJT6YYXSFU+KxmTvQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 11, 2019 at 10:10 PM Michael Moese <mmoese@suse.de> wrote:

> ...
> +
> +static void setup(void)
> +{
> +       tst_fzsync_pair_init(&fzsync_pair);
> +       tst_taint_init(TST_TAINT_W | TST_TAINT_D);
> +       snd_fd = SAFE_OPEN("/dev/snd/timer",
> +                       O_RDONLY|O_CREAT|O_NOCTTY|O_SYNC|O_LARGEFILE, 0);
>

Should we check if the file exists before opening it?

Otherwise, snd_timer01 failed as:

# ./snd_timer01
tst_test.c:1100: INFO: Timeout per run is 0h 05m 00s
safe_macros.c:225: BROK: snd_timer01.c:73: open(/dev/snd/timer,1052992,00)
failed: ENOENT

# lsmod |grep -i snd

# grep -i snd /boot/config-4.18.0-107.el8.s390x

# ls /dev/snd/timer
ls: cannot access '/dev/snd/timer': No such file or directory

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190716/3c171fad/attachment.htm>
