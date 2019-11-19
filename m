From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Nov 2019 05:02:34 -0500 (EST)
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <6371c082-ac3a-3daf-9196-481973f85b04@suse.cz>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
 <CAEemH2eu8HcQ90+BxUL0Hu+No6P5je4xC3oqVSU_ZnwMXEG=7Q@mail.gmail.com>
 <1824199572.12930798.1574151212869.JavaMail.zimbra@redhat.com>
 <6371c082-ac3a-3daf-9196-481973f85b04@suse.cz>
Message-ID: <1061994684.12955452.1574157754643.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > ----- Original Message -----
> > fallocate05 seems to be the only test using it, but in general I think we
> > can do that too. Assuming this alone would be reliable, is there any
> > advantage of running test with small FALLOCATE_SIZE?
> 
> Note that simply increasing FALLOCATE_SIZE will not fix an incorrect
> pass when the file system wasn't completely full. Here's the code that
> checks whether some blocks were properly fallocate()d:
> 
> tst_fill_fs(MNTPOINT, 1);
> ret = write(fd, buf, sizeof(buf));
> if (ret < 0)
> 	tst_res(TFAIL | TERRNO, "write() failed unexpectedly");
> else
> 	tst_res(TPASS, "write() wrote %zu bytes", ret);
> 
> If the file system somehow finds a few free blocks after tst_fill_fs()
> returns, short write() will still count as a pass.

That is good point, but that seems like issue that existed even with
8k FALLOCATE_SIZE, right?

