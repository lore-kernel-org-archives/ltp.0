From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Jun 2021 13:20:40 -0400
Subject: [LTP] [BUG] btrfs potential failure on 32 core LTP test
 (fallocate05)
In-Reply-To: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
Message-ID: <e4c71c01-ed70-10a6-be4d-11966d1fcb75@toxicpanda.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 6/29/21 1:00 PM, Krzysztof Kozlowski wrote:
> Dear BTRFS folks,
> 
> I am hitting a potential regression of btrfs, visible only with
> fallocate05 test from LTP (Linux Test Project) only on 32+ core Azure
> instances (x86_64).
> 
> Tested:
> v5.8 (Ubuntu with our stable patches): PASS
> v5.11 (Ubuntu with our stable patches): FAIL
> v5.13 mainline: FAIL
> 
> PASS means test passes on all instances
> FAIL means test passes on other instance types (e.g. 4 or 16 core) but
> fails on 32 and 64 core instances (did not test higher),
> e.g.: Standard_F32s_v2, Standard_F64s_v2, Standard_D32s_v3,
> Standard_E32s_v3
> 
> Reproduction steps:
> git clone https://github.com/linux-test-project/ltp.git
> cd ltp
> ./build.sh && make install -j8
> cd ../ltp-install
> sudo ./runltp -f syscalls -s fallocate05
> 

This thing keeps trying to test ext2, how do I make it only test btrfs?  Thanks,

Josef
