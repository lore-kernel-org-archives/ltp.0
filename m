From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 29 Jun 2021 16:14:43 -0400
Subject: [LTP] [BUG] btrfs potential failure on 32 core LTP test
 (fallocate05)
In-Reply-To: <9e2214b1-999d-90cf-a5c2-2dbb5a2eadd4@canonical.com>
References: <a3b42abc-6996-ab06-ea9f-238e7c6f08d7@canonical.com>
 <124d7ead-6600-f369-7af1-a1bc27df135c@toxicpanda.com>
 <667133e5-44cb-8d95-c40a-12ac82f186f0@canonical.com>
 <0b6a502a-8db8-ef27-f48e-5001f351ef24@toxicpanda.com>
 <2576a472-1c99-889a-685c-a12bbfb08052@canonical.com>
 <9e2214b1-999d-90cf-a5c2-2dbb5a2eadd4@canonical.com>
Message-ID: <62d1df14-7ee5-8ff4-5676-cf98cdd966df@toxicpanda.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 6/29/21 2:28 PM, Krzysztof Kozlowski wrote:
> On 29/06/2021 20:06, Krzysztof Kozlowski wrote:
>> Minor update - it's not only Azure's. AWS m5.8xlarge and m5.16xlarge (32
>> and 64 cores) fail similarly. I'll try later also QEMU machines with
>> different amount of CPUs.
>>
> 
> Test on QEMU machine with 31 CPUs passes. With 32 CPUs - failure as
> reported.
> 
> dmesg is empty - no error around this.
> 
> Maybe something with per-cpu variables?
> 

Can I get y'alls .config?  I ran it on one of my 80cpu boxes and it didn't 
reproduce on my new code or on 5.12.  Thanks,

Josef
