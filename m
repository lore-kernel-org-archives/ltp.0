From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 15 Jul 2021 10:44:56 +0200
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <60EFF034.6070800@fujitsu.com>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
 <60EFF034.6070800@fujitsu.com>
Message-ID: <4aaba9d9-e013-3c12-500a-647ff2c0b82d@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,


On 7/15/2021 10:21 AM, xuyang2018.jy@fujitsu.com wrote:
>
>> +	tst_cmd(argv, "/dev/null", NULL, 0);
> We have SAFE_CMD api.
Yes makes sense. This can be replaced during merge I guess.
-?????? tst_cmd(argv, "/dev/null", NULL, 0);
+?????? SAFE_CMD(argv, "/dev/null", NULL);
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.cleanup = cleanup,
>> +	.setup = setup,
>> +	.needs_root = 1,
>> +	.needs_device = 1,
>> +	.dev_min_size = 1,
>> +	.needs_cmds = (const char *const []) {
>> +		"mksquashfs",
>> +		NULL
>> +	},
>> +	.needs_drivers = (const char *const []) {
>> +		"squashfs",
>> +		NULL
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "c1b2028315c"},
>> +		{"linux-git", "8b44ca2b634"},
>> +		{}
>> +	},
>> +	.needs_tmpdir = 1,
> needs_device has enabled needs_tmpdir in internal, so we don't need to
> set it here.
Honestly I hate implicitness like that. I think if the test itself needs 
the tmpdir, it should state it and not rely on some other "needs_*" 
stuff to also enable it.
But if whoever merges this agrees with you, he can change it...

Joerg
