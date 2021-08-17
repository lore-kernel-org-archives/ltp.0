From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 17 Aug 2021 12:33:24 +0200
Subject: [LTP] [PATCH 3/3] Add test for CVE 2018-13405
In-Reply-To: <87sfz8l68q.fsf@suse.de>
References: <20210806154557.19551-1-mdoucha@suse.cz>
 <20210806154557.19551-3-mdoucha@suse.cz> <87sfz8l68q.fsf@suse.de>
Message-ID: <f1b416ce-cacf-55be-a7cd-bcff821d0ec7@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17. 08. 21 12:23, Richard Palethorpe wrote:
> Hello Martin,
> 
> Martin Doucha <mdoucha@suse.cz> writes:
>> +static void setup(void)
>> +{
>> +	struct stat buf;
>> +	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
>> +	struct group *ltpgroup = SAFE_GETGRNAM("bin");
> 
> These might not exist on some systems. I think you can just pick
> arbitrary UID/GID numbers instead. No need to check the user/group
> databases.

I'm planning to rewrite this test after the first two patches get
merged. See previous discussion under the creat08 patch.


>> +static void cleanup(void)
>> +{
>> +	SAFE_SETREUID(-1, orig_uid);
> 
> Why are you doing this? I am assuming the temp dir will be deleted by
> the parent process.

That assumption is incorrect.

https://github.com/linux-test-project/ltp/commit/3833d44a2ba3773359d3b35a2108af691d75b4f9

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
