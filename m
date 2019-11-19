From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 19 Nov 2019 10:47:14 +0100
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <1824199572.12930798.1574151212869.JavaMail.zimbra@redhat.com>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
 <CAEemH2eu8HcQ90+BxUL0Hu+No6P5je4xC3oqVSU_ZnwMXEG=7Q@mail.gmail.com>
 <1824199572.12930798.1574151212869.JavaMail.zimbra@redhat.com>
Message-ID: <6371c082-ac3a-3daf-9196-481973f85b04@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/19/19 9:13 AM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> Another patch I was thinking is to enhance the tst_fill_fs routine, which
>> as Eric suggested, makes more reliably to get to a full filesystem.
>> Something like what xfstest does to cut the trial write size in half and
>> try again until the size is less than the filesystem block size.
>>
>> Comments?
> 
> fallocate05 seems to be the only test using it, but in general I think we
> can do that too. Assuming this alone would be reliable, is there any
> advantage of running test with small FALLOCATE_SIZE?

Note that simply increasing FALLOCATE_SIZE will not fix an incorrect
pass when the file system wasn't completely full. Here's the code that
checks whether some blocks were properly fallocate()d:

tst_fill_fs(MNTPOINT, 1);
ret = write(fd, buf, sizeof(buf));
if (ret < 0)
	tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
else
	tst_res(TPASS, "write() wrote %zu bytes", ret);

If the file system somehow finds a few free blocks after tst_fill_fs()
returns, short write() will still count as a pass.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
