From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Nov 2020 21:32:36 +0800
Subject: [LTP] [PATCH 2/2] syscalls: quotactl04,
 statx05: Fix TWARN on missing mkfs
In-Reply-To: <20201124130425.4264-1-chrubis@suse.cz>
References: <20201124130425.4264-1-chrubis@suse.cz>
Message-ID: <CAEemH2d2E0evCwsAQkFFJcKn4Bw4J9yp+i1LtWetJWxXO2WB7Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 24, 2020 at 9:03 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> When mkfs.ext4 was missing we would get TWARN because the setup will fail
> to
> parse the mkfs version followed by TCONF from the library function that
> attempts format the device.
>
> Fix this by requiring the mkfs.ext4 in the tst_test structure which will
> exit
> the test before we attempt to parse the mkfs version.
>

Merged, thanks~

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201124/a338f0f7/attachment.htm>
