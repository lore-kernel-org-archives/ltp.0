From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 30 Mar 2021 12:36:54 +0200
Subject: [LTP] [PATCH 1/1] tst_mkfs: Add -I option to mkfs.vfat
In-Reply-To: <87czvhneqb.fsf@suse.de>
References: <20210329145738.986-1-pvorel@suse.cz> <87czvhneqb.fsf@suse.de>
Message-ID: <41d6efe9-c028-6029-44c0-974222832051@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30. 03. 21 12:00, Richard Palethorpe wrote:
> Hello,
> 
> Petr Vorel <pvorel@suse.cz> writes:
> 
>> to workaround occasional error on tests with .all_filesystems flag:
>>
>> tst_test.c:888: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
>> mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0',
>>  not making filesystem (use -I to override)
>> tst_test.c:888: TBROK: mkfs.vfat failed with exit code 1
>>
>> Tested also on BusyBox v1.33.0, which accept but ignores -I since
>> beginning (1.14.0).
>>
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>> Richard also suggested to wipe the device, but not sure how to do it
>> quickly and don't bring any more dependency.
> 
> I guess that you only need to wipe the headers by writing zeros to the
> device. That is unless this is actually refering to a mapping in
> /dev/mapper?

We already call tst_clear_device(dev) in tst_mkfs_() but mkfs.vfat keeps
randomly failing with loop devices anyway.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
