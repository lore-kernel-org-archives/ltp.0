From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 23 Jun 2016 15:38:11 +0300
Subject: [LTP] [PATCH 2/2] nfs05: rewrite the test,
 make use of new library
In-Reply-To: <20160623115438.GB19250@rei.lan>
References: <1466076425-12790-1-git-send-email-alexey.kodanev@oracle.com>
 <1466076425-12790-2-git-send-email-alexey.kodanev@oracle.com>
 <20160622123017.GC13962@rei.lan> <576BCE87.5070403@oracle.com>
 <20160623115438.GB19250@rei.lan>
Message-ID: <576BD833.7020502@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/23/2016 02:54 PM, Cyril Hrubis wrote:
> Hi!
>>>>    
>>>> -			dprt("pid[%d]: init_compile(): status = %d\n",
>>>> -			     gettid(), status);
>>>> -			dprt("we are here %d\n", __LINE__);
>>>> -			return status;
>>>> +			SAFE_WRITE(1, fd, prog_buf, prog_buf_size);
>>>> +			fsync(fd);
>>> Why do we fsync(fd) here? Isn't the whole point of this test to find a
>>> race conditions?
>> And given the fact that we have close(fd) thereafter, should make it
>> useless...
> fsync() should cause the page caches to be written to the disk, close()
> just frees the associated file descriptor and page caches are written on
> background.
In case of NFS?

