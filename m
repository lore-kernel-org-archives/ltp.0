From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 14 Dec 2016 18:03:39 +0300
Subject: [LTP] [PATCH 1/1] network: fix network.sh -e option
In-Reply-To: <20161214142422.GC20141@rei.lan>
References: <20161130100720.3577-1-pvorel@suse.cz>
 <20161214142422.GC20141@rei.lan>
Message-ID: <58515F4B.9070604@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
On 12/14/2016 05:24 PM, Cyril Hrubis wrote:
> Hi!
>> a94a669 added 's' to filename => rename to original version
> Looks good to me.
>
> Alexej: should we commit this rename or should we rather change the
> filename in the network.sh script?

Either way is fine to me, let's rename it back to the original name 
without 's'.

Best regards,
Alexey

