From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 16 Jun 2021 11:16:28 +0200
Subject: [LTP] [PATCH v2] syscalls/mallinfo2_01: Add a basic test for
 mallinfo2 when setting 2G size
In-Reply-To: <YMmiQfWgvqtCzOmg@pevik>
References: <YKzX7FPWGGROn6kR@pevik>
 <1622713444-21197-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YMmiQfWgvqtCzOmg@pevik>
Message-ID: <da3974e4-76ee-1eee-b730-c49953c21120@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 6/16/2021 9:03 AM, Petr Vorel wrote:
>
> BTW Cyril also suggested recently to drop out of tree support, because build
> system dependencies are broken and fixing it would be much easier when
> supporting only in tree build.
Really? I got the feeling out-of-tree builds are becoming the new normal 
and even complex pieces of software like the kernel, glibc and gcc are 
able to be built out-of-tree or even enforce it.
Maybe it is time to abandon autoconf/automake and switch to a better 
build configuration systems like cmake instead of abandoning out-of-tree 
builds.

J?rg
