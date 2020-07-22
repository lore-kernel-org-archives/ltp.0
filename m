From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Wed, 22 Jul 2020 14:34:26 -0400
Subject: [LTP] [PATCH v2] IMA: Add test for kexec cmdline measurement
In-Reply-To: <1595441389.5211.1.camel@linux.ibm.com>
References: <20200722164040.23109-1-t-josne@linux.microsoft.com>
 <1595441389.5211.1.camel@linux.ibm.com>
Message-ID: <d1908820-cb58-6196-3ecd-243aa7a652bf@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you for signing off on this patch!

I apologize for the issues on applying. I should've caught the trailing 
spaces, but the inability to apply the README
is actually a result of this patch being based on the custom keyring 
patch that I sent out last Friday [1].

[1]: [PATCH] IMA: Add a test to verify importing a certificate into 
custom keyring

On 7/22/20 2:09 PM, Mimi Zohar wrote:
> On Wed, 2020-07-22 at 12:40 -0400, Lachlan Sneff wrote:
>> IMA policy can be set to measure the command line passed in the kexec system call.
>> There needs to be a test to validate this kexec command line measurement.
>>
>> Add a testcase that verifies that the IMA subsystem has correctly
>> measured the cmdline specified during a kexec.
>>
>> Note that this test does not actually reboot.
>>
>> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> Other than the patch not applying cleanly and leading blanks,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

