From: Li Wang <liwang@redhat.com>
Date: Wed, 8 May 2019 13:50:09 +0800
Subject: [LTP] [PATCH 1/2] numa: fix numa test error with non-continuous
	nodes
In-Reply-To: <20190508052318.9020-2-liwang@redhat.com>
References: <20190508052318.9020-2-liwang@redhat.com>
Message-ID: <CAEemH2fxyK48dffwvyCkbmZ59rvSUuLUeZW9MCYjBNhBi86Axw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 8, 2019 at 1:23 PM Li Wang <liwang@redhat.com> wrote:

> Numa test failed on such machine which has non-continuous numa nodes,
> it gets wrong data because of the below syntax rule is not applicable
> to that special situation.
>   ` numastat -p $pid |awk '/^Total/ {print $'$((node+2))'}'
> In this patch, we fix that to print the last column replacing by '$NF'
> in awk.
>   ` numastat -p $pid |awk '/^Total/ {print $NF}'
>

Bah, I made a mistake on the node memory counting, it should be the asgd
node but not total, I will fix it in PATCH v2. Plz ignore this one. Sorry
about that.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190508/2e0c774c/attachment.html>
