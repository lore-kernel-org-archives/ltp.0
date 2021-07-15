From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 15 Jul 2021 12:12:02 +0200
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <YO//gakCvqaDZl9f@yuki>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
 <60EFF034.6070800@fujitsu.com>
 <4aaba9d9-e013-3c12-500a-647ff2c0b82d@jv-coder.de> <YO//gakCvqaDZl9f@yuki>
Message-ID: <f2fd323e-a5da-2959-d130-2d3c0aa59e89@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On 7/15/2021 11:27 AM, Cyril Hrubis wrote:
> Hi!
>>>> +static struct tst_test test = {
>>>> +	.test_all = run,
>>>> +	.cleanup = cleanup,
>>>> +	.setup = setup,
>>>> +	.needs_root = 1,
>>>> +	.needs_device = 1,
>>>> +	.dev_min_size = 1,
>>>> +	.needs_cmds = (const char *const []) {
>>>> +		"mksquashfs",
>>>> +		NULL
>>>> +	},
>>>> +	.needs_drivers = (const char *const []) {
>>>> +		"squashfs",
>>>> +		NULL
>>>> +	},
>>>> +	.tags = (const struct tst_tag[]) {
>>>> +		{"linux-git", "c1b2028315c"},
>>>> +		{"linux-git", "8b44ca2b634"},
>>>> +		{}
>>>> +	},
>>>> +	.needs_tmpdir = 1,
>>> needs_device has enabled needs_tmpdir in internal, so we don't need to
>>> set it here.
>> Honestly I hate implicitness like that. I think if the test itself needs
>> the tmpdir, it should state it and not rely on some other "needs_*"
>> stuff to also enable it.
>> But if whoever merges this agrees with you, he can change it...
> We tend to avoid listing full subtree of dependencies, in this case it's
> not that bad, but it tends to get out of hand quickly.
>
> For instance mount_device flag needs implies format_device which implies
> needs_device which implies needs_tmpdir.
I agree with that. If needs_tmpdir was only required, because 
needs_device is required, I wouldn't add it.
But if needs_device implementation is changed, the test still needs a 
tmpdir. That's why I would always vote for adding it here.
> Also the dev_min_size = 1 does not have any efect here, since it can be
> used only to request bigger-than-default size and gets ignored here. I
> guess that we can merge this as it is and I will add needs_loopdev to
> the tst_test structure later which will just allocate loop device and
> pass it down to the test.
This is true, but the test should also specify what it needs. If for 
whatever reason DEV_SIZE_MB is redefined to a smaller value, the test 
would still work.
To be honest, for "1" it doesn't matter. But it it was bigger, it makes 
total sense to specify the size if the test knows it...

I don't understand why a lot of developers like implicit definitions so 
much more over explicit definitions.
I could understand it for language intrinsic stuff, because that is (or 
could be) known to all developers.
But for someone, who rarely works on a project or switches between 
different projects implicit information is bad!

Joerg

