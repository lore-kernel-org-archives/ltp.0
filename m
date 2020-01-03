From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 3 Jan 2020 09:56:52 -0800
Subject: [LTP] [PATCH 5.4 000/191] 5.4.8-stable review
In-Reply-To: <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com>
References: <20200102215829.911231638@linuxfoundation.org>
 <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <20200103154518.GB1064304@kroah.com>
 <CAK8P3a00SpVfSE5oL8_F_8jHdg_8A5fyEKH_DWNyPToxack=zA@mail.gmail.com>
 <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com>
Message-ID: <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/3/20 9:33 AM, Mike Kravetz wrote:
> On 1/3/20 7:56 AM, Arnd Bergmann wrote:
>> On Fri, Jan 3, 2020 at 4:45 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> On Fri, Jan 03, 2020 at 04:29:56PM +0100, Arnd Bergmann wrote:
>>>> On Fri, Jan 3, 2020 at 4:25 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>
>>>>> On Fri, Jan 3, 2020 at 4:03 PM Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>>>>
>>>>>> On Fri, 3 Jan 2020 at 03:42, Greg Kroah-Hartman
>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>
>>>>> -ENOENT is what you get when hugetlbfs is not mounted, so this hints to
>>>>>
>>>>> 8fc312b32b2  mm/hugetlbfs: fix error handling when setting up mounts
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-5.4.y&id=3f549fb42a39bea3b29c0fc12afee53c4a01bec9
>>>>
>>>> I see that Mike Kravetz suggested not putting this patch into stable in
>>>>
>>>> https://lore.kernel.org/lkml/befca227-cb8a-8f47-617d-e3bf9972bfec@oracle.com/
>>>>
>>>> but it was picked through the autosel mechanism later.
>>>
>>> So does that mean that Linus's tree shows this LTP failure as well?
>>
>> Yes, according to
>> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/memfd_create04
>> mainline has the same testcase failure, it started happening between
>> v5.4-10135-gc3bfc5dd73c6 and v5.4-10271-g596cf45cbf6e, when the patch
>> was originally merged into 5.5-rc1.
>>
>>> This does seem to fix a real issue, as shown by the LTP test noticing
>>> it, so should the error code value be fixed in Linus's tree?
>>
>> No idea what to conclude from the testcase failure, let's see if Mike has
>> any suggestions.
>>
> 
> Thanks for isolating to this patch!
> 
> There are dependencies between arch specific code and arch independent code
> during the setup of hugetlb sizes/mounts.  Let me take a closer look at the
> arm64 code and get access to a system for debug.

Before I started investigating, Jan Stancek found and fixed the issue.

http://lkml.kernel.org/r/a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com

-- 
Mike Kravetz
