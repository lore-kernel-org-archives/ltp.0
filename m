From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 2 Aug 2021 14:07:24 +0200
Subject: [LTP] [PATCH] lib: tst_device: Allow more control over the
 device size
In-Reply-To: <YQfaZsdzHbPrhCV0@yuki>
References: <20210730133155.31284-1-chrubis@suse.cz>
 <d99456d3-c3d3-a180-7d0c-55bc3042e63c@jv-coder.de> <YQfZLXZznHjvlGJW@yuki>
 <YQfaZsdzHbPrhCV0@yuki>
Message-ID: <e51c9469-73e5-69db-f5ff-c2abfd72dc95@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 8/2/2021 1:43 PM, Cyril Hrubis wrote:
>>> This is not enough. tst_acquire_device__ calls tst_acquire_loop_device,
>>> that again has MAX(size, DEV_SIZE_MB).
>>> But it should be sage to substitute it for size ? size : DEV_SIZE_MB as
>>> well.
>> Right, that was the old API function to get loop devices which was
>> called from old API testcases. Looks like there are no old API tests
>> that work with loop devices anymore, so this function should be removed
>> from the public API as well. I will send v2 patchset.
> Uff, that was tst_acquire_device_() not tst_acquire_loop_device() and
> tst_acquire_device_() is still in use.
>
> I'm really looking forward to a day where we can finally remove the old
> API from the library...
The usage of foo foo_ and foo__ does not really help in reading the code :)
There could also be some logic errors hiding, e.g. 
tst_acquire_loop_device should probably not default to DEV_SIZE_MB at all.
The caller should be responsible for finding a correct size and the two 
users of this function (tst_device [the binary] and 
tst_acquire_device__) do pass a concrete value for size.

Joerg
