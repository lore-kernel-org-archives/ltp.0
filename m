From: Eric Biggers <ebiggers@google.com>
Date: Fri, 1 Dec 2017 11:21:52 -0800
Subject: [LTP] 3239b6f29b ("KEYS: return full count in keyring_read() if
 buffer is too small"): ltp.keyctl06.fail
In-Reply-To: <20171201024012.wsq3xnsbbdqwxwp2@wfg-t540p.sh.intel.com>
References: <20171201024012.wsq3xnsbbdqwxwp2@wfg-t540p.sh.intel.com>
Message-ID: <20171201192152.GD142348@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Dec 01, 2017 at 10:40:12AM +0800, Fengguang Wu wrote:
> Hi Eric,
> 
> We noticed LTP keyctl06 test regression in
> 
> commit: 3239b6f29bdfb4b0a2ba59df995fc9e6f4df7f1f ("KEYS: return full count in keyring_read() if buffer is too small")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> on test machine: 48 threads Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz with 64G memory
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: syscalls_part2
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp install job.yaml  # job file is attached in this email
>          bin/lkp run     job.yaml
> 
> testcase/path_params/tbox_group/run: ltp/1HDD-ext4-syscalls_part2/ivb44
> 

Did this include LTP commit f21703fe45d3 ("syscalls/keyctl06: update to test for
follow-on fix")?  It would be really helpful if these reports would include the
LTP commit that was used.

Eric
