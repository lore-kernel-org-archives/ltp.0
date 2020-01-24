From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 24 Jan 2020 13:09:09 +0100
Subject: [LTP] [PATCH v3 1/3] Add tst_purge_dir() helper function
In-Reply-To: <20200124102323.GB28992@rei.lan>
References: <20200123162019.18958-1-mdoucha@suse.cz>
 <20200123162019.18958-2-mdoucha@suse.cz> <20200124102323.GB28992@rei.lan>
Message-ID: <dab8858a-4a0b-3413-02b6-5e32bd3b2ddf@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/24/20 11:23 AM, Cyril Hrubis wrote:
>> -	fd = open(obj, O_DIRECTORY | O_NOFOLLOW);
>> -	if (fd != -1) {
>> -		close(fd);
>> +	errno = 0;
>> +	fd = open(path, O_DIRECTORY | O_NOFOLLOW);
>>  
>> -		/* Do NOT perform the request if the directory is "/" */
>> -		if (!strcmp(obj, "/")) {
>> -			if (errmsg != NULL) {
>> -				sprintf(err_msg, "Cannot remove /");
>> -				*errmsg = err_msg;
>> -			}
>> -			return -1;
>> +	if (fd < 0) {
>> +		if (errptr) {
>> +			sprintf(err_msg,
>> +				"Cannot open directory %s; errno=%d: %s",
>> +				path, errno, tst_strerrno(errno));
>> +			*errptr = err_msg;
>>  		}
> 
> Isn't this check useless here? Or are we trying to avoid escaping the
> directory via symlink?

You're right. I've just blindly copied the check from rmobj() which uses
it to decide whether the FS node should be removed using rmdir() or
unlink(). I'll move the open() check to tst_purge_dir() so it doesn't
get called twice for each subdirectory and drop the useless O_NOFOLLOW.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
