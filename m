From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Jan 2017 14:08:36 +0300
Subject: [LTP] LTP release status
In-Reply-To: <20170112142828.GC1208@rei.lan>
References: <20170112142828.GC1208@rei.lan>
Message-ID: <5878B534.5020200@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
On 12.01.2017 17:28, Cyril Hrubis wrote:
> Hi!
> I'm done with pre-release testing. The last thing I would like to
> include are fixes for running 32bit LTP on 64bit kernel, particulary
> [PATCH 1/4] lib: Add tst_kernel_bits() patchset and possibly fix the
> issue https://github.com/linux-test-project/ltp/issues/124.
>
> Anything else?
>
> I would like to finally do the release at the start of the next week, is
> that OK with everyone or do we need some more time for pre-release
> testruns?

OK for me. There are NFS test group issues with netns setup, the same as 
found by Petr with telnet test. Don't have working solution right now,  
defer to the next release.

Thanks,
Alexey

