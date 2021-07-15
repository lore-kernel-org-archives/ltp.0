From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 15 Jul 2021 12:40:03 +0200
Subject: [LTP] [PATCH v3] squashfs: Add regression test for sanity check
 bug
In-Reply-To: <YPAJcuQ7irZAI+1Z@yuki>
References: <20210715050812.1950884-1-lkml@jv-coder.de>
 <60EFF034.6070800@fujitsu.com>
 <4aaba9d9-e013-3c12-500a-647ff2c0b82d@jv-coder.de> <YO//gakCvqaDZl9f@yuki>
 <f2fd323e-a5da-2959-d130-2d3c0aa59e89@jv-coder.de> <YPAJcuQ7irZAI+1Z@yuki>
Message-ID: <de3a63e6-3b4c-20ff-3ee6-00fb4d181e98@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi C

On 7/15/2021 12:09 PM, Cyril Hrubis wrote:
> Hi!
>>> For instance mount_device flag needs implies format_device which implies
>>> needs_device which implies needs_tmpdir.
>> I agree with that. If needs_tmpdir was only required, because
>> needs_device is required, I wouldn't add it.
>> But if needs_device implementation is changed, the test still needs a
>> tmpdir. That's why I would always vote for adding it here.
> The .needs_device flag implies .needs_tmpdir that's a part of the test
> library API.
>
>>> Also the dev_min_size = 1 does not have any efect here, since it can be
>>> used only to request bigger-than-default size and gets ignored here. I
>>> guess that we can merge this as it is and I will add needs_loopdev to
>>> the tst_test structure later which will just allocate loop device and
>>> pass it down to the test.
>> This is true, but the test should also specify what it needs. If for
>> whatever reason DEV_SIZE_MB is redefined to a smaller value, the test
>> would still work.
> The DEV_SIZE_MB will never go backward, this is actually the minimal
> size that is needed in order to create all supported Linux filesystems
> and we need to bump the size up every few years. I think that it was
> 100MB when I started to work on LTP and it got up to 256MB, which is
> also the reason the tests cannot know and why this is hidden in the
> library.
>
>> To be honest, for "1" it doesn't matter. But it it was bigger, it makes
>> total sense to specify the size if the test knows it...
> Also LTP allows to be passed a real block device to the tests, in a case
> that you want to test a block driver, in which case the test has no
> exact controll on the device size, which is also the reason why we
> allow minimal size to be specified but not exact size.
>
>> I don't understand why a lot of developers like implicit definitions so
>> much more over explicit definitions.
>> I could understand it for language intrinsic stuff, because that is (or
>> could be) known to all developers.
>> But for someone, who rarely works on a project or switches between
>> different projects implicit information is bad!
> I think that we can actually make things better by adding all of the
> text I've written above as a top level description in the tst_device.c.
>

I guess we agree to disagree on this matter. It is the same as the 
discussion mailinglist vs. github for patches.
Change the metadata in whatever way you like while merging.

Joerg
