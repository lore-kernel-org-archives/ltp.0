From: Rachel Sibley <rasibley@redhat.com>
Date: Mon, 18 Nov 2019 10:00:08 -0500
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E4?=
 =?utf-8?q?=2E0-rc7-e1918f0=2Ecki_=28stable-next=29?=
In-Reply-To: <1987216338.12689847.1573913007381.JavaMail.zimbra@redhat.com>
References: <cki.FB80424DEC.V1BSM19IWA@redhat.com>
 <1987216338.12689847.1573913007381.JavaMail.zimbra@redhat.com>
Message-ID: <82b4311e-1d2f-8af7-22f1-2883b71a2a80@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 11/16/19 9:03 AM, Jan Stancek wrote:
> ----- Original Message -----
>> Hello,
>>
>> We ran automated tests on a recent commit from this kernel tree:
>>
>>         Kernel repo:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/sashal/linux-stable.git
>>              Commit: e1918f0cc92b - kcov: remote coverage support
>>
>> The results of these automated tests are provided below.
>>
>>      Overall result: FAILED (see details below)
>>               Merge: OK
>>             Compile: OK
>>               Tests: FAILED
>>
>> All kernel binaries, config files, and logs are available for download here:
>>
>>    https://artifacts.cki-project.org/pipelines/288750
>>
>> One or more kernel tests failed:
>>
>>      x86_64:
>>       ? LTP lite
> Not a kernel problem.
>
> Rachel,
>
> You appear to be running LTP which doesn't have commit below.
> Host CPU where this failed is family 6, model 71 (INTEL_FAM6_BROADWELL_G).
>
> commit 0807a8258fbcf216bdd79a8d74a34b07bb42d8d3
> Author: Jan Stancek <jstancek@redhat.com>
> Date:   Mon Oct 28 14:33:26 2019 +0100
>
>      pt_test: skip pt_disable_branch on Broadwell CPUs
>      
>      commit d35869ba348d ("perf/x86/intel/pt: Allow the disabling of branch tracing")
>      disallows not setting BRANCH_EN due to erratum BDM106 on Broadwell CPUs.
Thanks? Jan, I'm working on updating LTP to a recent commit now, I'll cc 
you in the ticket.

