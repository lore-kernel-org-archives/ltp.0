From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 18 Aug 2020 16:39:32 +0200
Subject: [LTP] [PATCH 1/4] Integrate tst_taint_check() into main LTP
 library
In-Reply-To: <1124120972.9071386.1597758876284.JavaMail.zimbra@redhat.com>
References: <20200811130502.12010-1-mdoucha@suse.cz>
 <1124120972.9071386.1597758876284.JavaMail.zimbra@redhat.com>
Message-ID: <ddde012b-5060-a49e-33dd-bdb6bfcb3e0d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18. 08. 20 15:54, Jan Stancek wrote:
> ----- Original Message -----
>>  static void do_test_setup(void)
>> @@ -1279,6 +1282,9 @@ static int fork_testrun(void)
>>  	alarm(0);
>>  	SAFE_SIGNAL(SIGINT, SIG_DFL);
>>  
>> +	if (tst_test->taint_check && tst_taint_check())
>> +		tst_brk(TBROK, "Kernel is now tainted.");
>> +
> 
> Shouldn't this be TFAIL?

The difference matters only in tests that have .all_filesystems = 1.
With TBROK, taint will kill the test when the current FS run finishes.
With TFAIL, the test will run through the remaining filesystems with
broken kernel and print the taint error message after each one (most
likely with lots of bogus errors on top).

I prefer the first behavior.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
