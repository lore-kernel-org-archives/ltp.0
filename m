From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Feb 2021 11:14:29 +0100
Subject: [LTP] [PATCH] cpu_hotplug: Add executable file's path
In-Reply-To: <F3D3F6AC3820BB4C9FCA340DB5C32CB403879BE2@dggeml511-mbs.china.huawei.com>
References: <F3D3F6AC3820BB4C9FCA340DB5C32CB403879BE2@dggeml511-mbs.china.huawei.com>
Message-ID: <YDTVheiu2gRPs3oQ@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for your review!
> 
> In many embedded system, before running testcases we need type in the following lines:
> 
>     #export LTPROOT=/opt/ltp
>     #export PATH="$PATH:$LTPROOT/testcases/bin"
>     # cpuhotplug02.sh -c 1 -l 1
> 
> It is not convenient for running test after every login.

This is what you have to do if you are not using the runltp script and
that's it. We will not add workarounds into our testcases.


Also nobody stops you from writing a short wrapper script such as:

$ cat run_test.sh

#!/bin/sh

export LTPROOT=/opt/ltp
export PATH="$PATH:$LTPROOT/testcases/bin"

$@

And then using it as:

./run_test.sh cpuhotplug02.sh -c 1 -l 1

-- 
Cyril Hrubis
chrubis@suse.cz
