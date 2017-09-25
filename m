From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Sep 2017 14:18:10 +0800
Subject: [LTP] [PATCH v4] thp01: Find largest arguments size
In-Reply-To: <20170922092802.10602-1-rpalethorpe@suse.com>
References: <20170922092802.10602-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2eTbMn_eh9Gs6Swo52XHwZyaav-GV0Q4uMmw7dD737_cA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 22, 2017 at 5:28 PM, Richard Palethorpe
<rpalethorpe@suse.com> wrote:
> Because of kernel commit da029c11e6b1 the arguments size for exec has been
> reduced considerably. This causes exec to fail with E2BIG, so we call it
> repeatedly with a decreasing number of arguments until it is successful.
>
> As far as I know, there is no other reliable and easy way to determine the
> maximum argument length.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---


Looks good!  V4 get pass on my two platforms:

kernel-4.9.13-v7.1.el7  armv7l
kernel-4.13.0+     x86_64



-- 
Li Wang
liwang@redhat.com
