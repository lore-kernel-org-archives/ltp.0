From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 08 Dec 2017 10:39:00 +0000
Subject: [LTP] [PATCH v3 09/12] syscalls/mount03: Copy setuid_test to
	execute instead of 'TEST FILE'
In-Reply-To: <20171208102658.GA13286@rei> (Cyril Hrubis's message of "Fri, 8
 Dec 2017 11:26:58 +0100")
References: <20171204163655.8838-1-punit.agrawal@arm.com>
 <20171204163655.8838-10-punit.agrawal@arm.com>
 <20171208102658.GA13286@rei>
Message-ID: <87609hwlkr.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>>  	case 5:
>>  		/* Validate MS_NOSUID flag of mount call */
>>  
>> -		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
>> -		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
>> +		TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
>> +		snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
>>  
>>  		SAFE_STAT(cleanup, file, &file_stat);
>>  
>> @@ -291,9 +291,8 @@ int test_rwflag(int i, int cnt)
>>  				/* reset the setup_uid */
>>  				if (status)
>>  					return 0;
>> -				else
>> -					return 1;
>>  			}
>> +			return 1;
>>  		}
>>  	case 6:
>>  		/* Validate MS_NOATIME flag of mount call */
>> @@ -373,6 +372,10 @@ static void setup(void)
>>  	strncpy(path, path_name, PATH_MAX);
>>  	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
>>  
>> +	SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
>> +	TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
>> +	SAFE_UMOUNT(cleanup, mntpoint);
>
> I'm, a bit confused now, do we copy the file here in the setup or in the
> actual test above? Surely we don't have to do both.

In an earlier email you said -

"... secondly you are supposed to use the TST_RESOURCE_COPY() macro
instead of the function itself and it should be done once in the test
setup as well as the code that sets the actual setuid bit."

And now I'm confused as I updated the patch as per your request (or so I
thought). Where's the disconnect?
