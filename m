From: Thomas Backlund <tmb@mageia.org>
Date: Fri, 3 Jan 2020 21:11:41 +0200
Subject: [LTP] [PATCH 5.4 000/191] 5.4.8-stable review
In-Reply-To: <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
References: <20200102215829.911231638@linuxfoundation.org>
 <CA+G9fYuPkOGKbeQ0FKKx4H0Bs-nRHALsFtwyRw0Rt5DoOCvRHg@mail.gmail.com>
 <CAK8P3a1+Srey_7cUd0xfaO8HdMv5tkUcs6DeDXzcUKkUD-DnGQ@mail.gmail.com>
 <CAK8P3a24EkUXTu-K2c-5B3w-LZwY7zNcX0dZixb3gd59vRw_Kw@mail.gmail.com>
 <20200103154518.GB1064304@kroah.com>
 <CAK8P3a00SpVfSE5oL8_F_8jHdg_8A5fyEKH_DWNyPToxack=zA@mail.gmail.com>
 <a2fc8b36-c512-b6dd-7349-dfb551e348b6@oracle.com>
 <8283b231-f6e8-876f-7094-d3265096ab9a@oracle.com>
 <CAHk-=wjvWTFn=C3mT5wA=mtOwXw44U+OHLVxk5DCe4v+7nOvKg@mail.gmail.com>
Message-ID: <c5c3b8c8-1dfe-2433-630c-06dbfb3d318b@mageia.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Den 03-01-2020 kl. 20:40, skrev Linus Torvalds:
> On Fri, Jan 3, 2020 at 9:59 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Before I started investigating, Jan Stancek found and fixed the issue.
>>
>> http://lkml.kernel.org/r/a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com
> 
> Applied upstream as commit 15f0ec941f4f ("mm/hugetlbfs: fix
> for_each_hstate() loop in init_hugetlbfs_fs()").
> 
> I didn't add a cc: stable, because the original didn't have one, and
> the "Fixes:" tag should make it happen.
> 
>                 Linus
> 

Does not seem to exist in public git yet, maybe you forgot to push ?

--
Thomas

