From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 May 2019 14:28:17 +0200
Subject: [LTP] Oldest still supported kernel
In-Reply-To: <5CDD44F6.6090700@cn.fujitsu.com>
References: <20190516073826.GA14532@dell5510>
 <1051593197.23090826.1557995723298.JavaMail.zimbra@redhat.com>
 <20190516090705.GA21814@rei.lan>
 <CAEemH2dj3Txm=otnF+UEg2eJY70wTC-5tbT2R1VfrB0qAxtqmQ@mail.gmail.com>
 <5CDD44F6.6090700@cn.fujitsu.com>
Message-ID: <20190516122817.GA875@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>   For Oldest supported , I don't think we must specify a kernel or glibc 
> oldest version.

Keeping special cases and workarounds for things that have been release
more than 15 years ago has a maintenance costs as well. It makes sense
to decide on oldest supported kernel/libc versions from time to time so
that we can get rid of these.

-- 
Cyril Hrubis
chrubis@suse.cz
