From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Wed, 7 Oct 2015 18:00:26 +0800
Subject: [LTP] [PATCH v3] fcntl/fcntl32.c: add F_SETLEASE and F_WRLCK
 argument test
In-Reply-To: <20150930164132.GC8256@rei.suse.cz>
References: <55EFA462.5010608@cn.fujitsu.com>
 <1442307339-16873-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <20150930164132.GC8256@rei.suse.cz>
Message-ID: <5614ED3A.10609@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Thanks for your reply.

On 2015/10/01 00:41, Cyril Hrubis wrote:
> Hi!
>> +int main(int ac, char **av)
>> +{
>> +	int lc;
>> +	int tc;
>> +	long type;
>> +
>> +	tst_parse_opts(ac, av, NULL, NULL);
>> +
>> +	setup();
>> +
>> +	switch ((type = tst_fs_type(cleanup, "."))) {
>> +	case TST_NFS_MAGIC:
>> +	case TST_RAMFS_MAGIC:
>> +	case TST_TMPFS_MAGIC:
>> +		tst_brkm(TCONF, cleanup, "%s filesystem does not support "
>> +			 "fcntl(2)'s F_SETLEASE operation",
>> +			 tst_fs_type_name(type));
>> +	default:
>> +		break;
>> +	}
> 
> Same as the second one. I would preffer figuring out that the fcntl() is
> unsupported by actually trying to use it.
> 

It will return EAGAIN when we actually use it, I don't think it's a reasonable errno,
since on ramfs or tmpfs, when opening or creating a new file, the dentry->d_count
will get an extra count to be 2 but not 1. Please have a look at the following link:
http://www.gossamer-threads.com/lists/linux/kernel/913113

I feel the expression is not clear, it should be "cannot do fcntl()'s F_SETLEASE operation
on %s filesystem"

> 
> Otherwise it looks fine.
> 
