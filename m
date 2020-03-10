From: Rachel Sibley <rasibley@redhat.com>
Date: Tue, 10 Mar 2020 10:42:31 -0400
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_PANICKED=3A_Test_report_for_kernel_5?=
 =?utf-8?q?=2E5=2E8-6afe1f4=2Ecki_=28stable-queue=29?=
In-Reply-To: <20200310095312.GA2534479@kroah.com>
References: <cki.FE14F151C1.JS9OFUV72I@redhat.com>
 <20200310095312.GA2534479@kroah.com>
Message-ID: <6e37f607-b607-7d05-bc21-b7b5a238af0a@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 3/10/20 5:53 AM, Greg KH wrote:
> On Tue, Mar 10, 2020 at 09:45:37AM -0000, CKI Project wrote:
>>
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>         Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>              Commit: 6afe1f4aeae9 - ASoC: topology: Fix memleak in soc_tplg_manifest_load()
>>
>> The results of these automated tests are provided below.
>>
>>      Overall result: FAILED (see details below)
>>               Merge: OK
>>             Compile: OK
>>               Tests: PANICKED
> 
> Given that there's nothing I can do about this, I'm just starting to
> flat-out ignore the results of these emails :(


Hi Greg, I'm sorry for all the noise, the fix has already been posted here:
https://lore.kernel.org/lkml/20200224030007.3990-1-cai@lca.pw/

While we wait for it to make into stable-queue, I'm working on masking this panic in CKI.
There were several tests which could trigger the panic, not just LTP, so we need to mask it
in a way that we don't mask real problems.

In the mean time I have already waived the audit failures, you should no longer see these
failures for new pipelines triggered.

> 
> greg k-h
> 

