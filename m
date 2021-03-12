From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 12 Mar 2021 18:00:49 +0100
Subject: [LTP] [PATCH v3] lib: Add proper filesystem skiplist
In-Reply-To: <YEt1MpgYOWYThZnN@yuki.lan>
References: <20210311105509.2701-2-chrubis@suse.cz>
 <20210312110620.13395-1-mdoucha@suse.cz> <YEt1MpgYOWYThZnN@yuki.lan>
Message-ID: <76d2c434-14c9-0c88-a982-5a0a72f9230b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12. 03. 21 15:05, Cyril Hrubis wrote:
> Hi!
>> The approach with flags we added for FUSE does not scale at all, we need
>> a proper skiplist so that we can skip individual filesystems.
>>
>> The motivation here is the addition of tmpfs to the supported
>> filesystems check. One of the problems there is that sync() is no-op on
>> tmpfs and hence the syncfs test fails. After this patchset we can simply
>> skip syncfs test on tmpfs by setting the right skiplist.
>>
>> As a bonus point the list of unsupported filesystem gets nicely
>> propagated to the metadata as well.
>>
>> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> Co-authored-by: Martin Doucha <mdoucha@suse.cz>
> 
> This would be just Signed-off-by:
> 
>> ---
>>
>> Moving the skiplist logic from has_kernel_support() to tst_fs_is_supported()
>> misses the point of my objection. This is the code I had in mind when I was
>> commenting on the patchset.
>>
>>  include/tst_fs.h                              | 26 +++++++---
>>  include/tst_test.h                            |  9 +++-
>>  lib/tst_supported_fs_types.c                  | 51 ++++++++++++++-----
>>  lib/tst_test.c                                |  2 +-
>>  .../kernel/syscalls/fsconfig/fsconfig01.c     |  2 +-
>>  testcases/kernel/syscalls/fsmount/fsmount01.c |  2 +-
>>  testcases/kernel/syscalls/fsmount/fsmount02.c |  2 +-
>>  testcases/kernel/syscalls/fsopen/fsopen01.c   |  2 +-
>>  testcases/kernel/syscalls/fspick/fspick01.c   |  2 +-
>>  testcases/kernel/syscalls/fspick/fspick02.c   |  2 +-
>>  .../kernel/syscalls/move_mount/move_mount01.c |  2 +-
>>  .../kernel/syscalls/move_mount/move_mount02.c |  2 +-
>>  .../kernel/syscalls/open_tree/open_tree01.c   |  2 +-
>>  .../kernel/syscalls/open_tree/open_tree02.c   |  2 +-
>>  .../sync_file_range/sync_file_range02.c       |  2 +-
>>  testcases/lib/tst_supported_fs.c              |  4 +-
>>  16 files changed, 79 insertions(+), 35 deletions(-)
>>
>> diff --git a/include/tst_fs.h b/include/tst_fs.h
>> index 4f7dd68d2..ae58a9647 100644
>> --- a/include/tst_fs.h
>> +++ b/include/tst_fs.h
>> @@ -44,6 +44,9 @@ enum {
>>  #define OVL_WORK	OVL_BASE_MNTPOINT"/work"
>>  #define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
>>  
>> +#define TST_FS_NATIVE 1
>> +#define TST_FS_FUSE   2
>> +
>>  /*
>>   * @path: path is the pathname of any file within the mounted file system
>>   * @mult: mult should be TST_KB, TST_MB or TST_GB
>> @@ -167,18 +170,29 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
>>   */
>>  int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
>>  
>> -#define TST_FS_SKIP_FUSE 0x01
>> -
>>  /*
>> - * Return 1 if a specified fiilsystem is supported
>> - * Return 0 if a specified fiilsystem isn't supported
>> + * Return TST_FS_NATIVE if a specified filesystem is supported by kernel
>> + * Return TST_FS_FUSE if a specified filesystem is supported through FUSE
>> + * Return 0 if a specified filesystem isn't supported
>> + *
>> + * @fs_type A filesystem type to check the support for.
>>   */
>> -int tst_fs_is_supported(const char *fs_type, int flags);
>> +int tst_fs_is_supported(const char *fs_type);
>>  
>>  /*
>>   * Returns NULL-terminated array of kernel-supported filesystems.
>> + *
>> + * @skiplist A NULL terminated array of filesystems to skip.
>> + */
>> +const char **tst_get_supported_fs_types(const char *const *skiplist);
>> +
>> +/*
>> + * Returns 1 if filesystem is in skiplist 0 otherwise.
>> + *
>> + * @fs_type A filesystem type to lookup.
>> + * @skiplist A NULL terminated array of fileystemsytems to skip.
>>   */
>> -const char **tst_get_supported_fs_types(int flags);
>> +int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
>>  
>>  /*
>>   * Creates and writes to files on given path until write fails with ENOSPC
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index 1fbebe752..4eee6f897 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -159,6 +159,13 @@ struct tst_test {
>>  	 */
>>  	int all_filesystems:1;
>>  
>> +	/*
>> +	 * The skip_filesystem is a NULL terminated list of filesystems the
>> +	 * test does not support. It can also be used to disable whole class of
>> +	 * filesystems with a special keyworks such as "fuse".
>> +	 */
>> +	const char *const *skip_filesystems;
>> +
>>  	/* Minimum number of online CPU required by the test */
>>  	unsigned long min_cpus;
>>  
>> @@ -197,8 +204,6 @@ struct tst_test {
>>  
>>  	/* Device filesystem type override NULL == default */
>>  	const char *dev_fs_type;
>> -	/* Flags to be passed to tst_get_supported_fs_types() */
>> -	int dev_fs_flags;
>>  
>>  	/* Options passed to SAFE_MKFS() when format_device is set */
>>  	const char *const *dev_fs_opts;
>> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
>> index 00ede549d..7a420f481 100644
>> --- a/lib/tst_supported_fs_types.c
>> +++ b/lib/tst_supported_fs_types.c
>> @@ -45,7 +45,22 @@ static int has_mkfs(const char *fs_type)
>>  	return 1;
>>  }
>>  
>> -static int has_kernel_support(const char *fs_type, int flags)
>> +int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
>> +{
>> +	unsigned int i;
>> +
>> +	if (!skiplist)
>> +		return 0;
>> +
>> +	for (i = 0; skiplist[i]; i++) {
>> +		if (!strcmp(fs_type, skiplist[i]))
>> +			return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int has_kernel_support(const char *fs_type)
>>  {
>>  	static int fuse_supported = -1;
>>  	const char *tmpdir = getenv("TMPDIR");
>> @@ -58,7 +73,7 @@ static int has_kernel_support(const char *fs_type, int flags)
>>  	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
>>  	if (errno != ENODEV) {
>>  		tst_res(TINFO, "Kernel supports %s", fs_type);
>> -		return 1;
>> +		return TST_FS_NATIVE;
>>  	}
>>  
>>  	/* Is FUSE supported by kernel? */
>> @@ -84,26 +99,36 @@ static int has_kernel_support(const char *fs_type, int flags)
>>  		return 0;
>>  	}
>>  
>> -	if (flags & TST_FS_SKIP_FUSE) {
>> -		tst_res(TINFO, "Skipping FUSE as requested by the test");
>> -		return 0;
>> -	}
>> -
>>  	tst_res(TINFO, "FUSE does support %s", fs_type);
>> -	return 1;
>> +	return TST_FS_FUSE;
>>  }
>>  
>> -int tst_fs_is_supported(const char *fs_type, int flags)
>> +int tst_fs_is_supported(const char *fs_type)
>>  {
>> -	return has_kernel_support(fs_type, flags) && has_mkfs(fs_type);
>> +	if (has_mkfs(fs_type))
>> +		return has_kernel_support(fs_type);
>> +
>> +	return 0;
>>  }
>>  
>> -const char **tst_get_supported_fs_types(int flags)
>> +const char **tst_get_supported_fs_types(const char *const *skiplist)
>>  {
>> -	unsigned int i, j = 0;
>> +	unsigned int ret, skip_fuse, i, j = 0;
>> +
>> +	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
>>  
>>  	for (i = 0; fs_type_whitelist[i]; i++) {
>> -		if (tst_fs_is_supported(fs_type_whitelist[i], flags))
>> +		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist))
> 
> I guess that we should print here that the filesystem is skipped
> otherwise there will be no information why it was skipped in the test
> output.

Yes, that makes sense.

>> +			continue;
>> +
>> +		ret = tst_fs_is_supported(fs_type_whitelist[i]);
>> +
>> +		if (ret == TST_FS_FUSE && skip_fuse) {
>> +			tst_res(TINFO, "Skipping FUSE as requested by test");
>> +			continue;
> 
> And here we produce two messages for FUSE based filesystems, one that
> it's supported and second that it's skipped in a case that it's
> supported.
> 
> It would probably be more consistent if we called the
> tst_fs_is_supported() unconditionally and filtered out skipped
> filesystems only if we get positive return value from
> tst_fs_is_supported().

Does it really matter? The main issue here is that the helper function
prints too much information in the successful case. It'd be better to
remove debug output from has_kernel_support() and instead print only one
line per file system in the tst_* functions:
- supported
- FUSE
- missing mkfs.%s
- missing mount support
- FUSE (skipped)
- skipped

But that would require redesigning the return value of
has_kernel_support() a bit more and moving the (silent) mkfs check there
as well. Either way, I'd leave that to a separate patchset.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
